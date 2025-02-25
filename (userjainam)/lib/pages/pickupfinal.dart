import 'package:flutter/material.dart';
import 'package:ewaste/pages/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ewaste/pages/credits.dart';
import 'package:ewaste/pages/dropImage.dart';

class PickupRequestPage extends StatefulWidget {
  final String requestId;
  const PickupRequestPage({required this.requestId, Key? key}) : super(key: key);

  @override
  _PickupRequestPageState createState() => _PickupRequestPageState();
}

class _PickupRequestPageState extends State<PickupRequestPage> {
  bool _showConfirmButton = false;
  int _currentStep = 0;
  final TextEditingController addressController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  int _totalCredits = 0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _savePickupRequest() async {
  try {
    final firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is not logged in! Please sign in again.')),
      );
      return;
    }

    final docRef = firestore.collection('usertemporary').doc(widget.requestId);

    // Fetch detection results from the pickupRequests collection
    QuerySnapshot detectionResults = await firestore
        .collection('pickupRequests')
        .doc(widget.requestId)
        .collection('results')
        .get();

    // Extract detection data
    List<Map<String, dynamic>> results = detectionResults.docs.map((doc) {
      return {
        'fileName': doc['fileName'],
        'detections': doc['detections'],
      };
    }).toList();

    // Save to the usertemporary collection
    await docRef.set({
      'uid': user.uid,
      'requestId': widget.requestId,
      'address': addressController.text,
      'scheduledDate': selectedDate.toIso8601String(),
      'scheduledTime': '${selectedTime.hour}:${selectedTime.minute}',
      'status': 'pending',
      'volunteerId': null,
      'results': results,
      'totalCredits': _totalCredits,
    });

    // ✅ Update user's totalCredits in the 'users' collection
    final userDocRef = firestore.collection('users').doc(user.uid);
    DocumentSnapshot userDoc = await userDocRef.get();

    if (userDoc.exists) {
      // If user exists, increment totalCredits and append pickup
      await userDocRef.update({
        'totalCredits': FieldValue.increment(_totalCredits),
        'pickups': FieldValue.arrayUnion([
          {
            'requestId': widget.requestId,
            'address': addressController.text,
            'scheduledDate': selectedDate.toIso8601String(),
            'credits': _totalCredits,
          }
        ])
      });
    } else {
      // Create user document if not present
      await userDocRef.set({
        'totalCredits': _totalCredits,
        'pickups': [
          {
            'requestId': widget.requestId,
            'address': addressController.text,
            'scheduledDate': selectedDate.toIso8601String(),
            'credits': _totalCredits,
          }
        ]
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pickup request saved successfully!')),
    );

    // Navigate to the confirmation page
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


  int calculateTotalCredits(List<QueryDocumentSnapshot> docs) {
  int totalCredits = 0;
  for (var doc in docs) {
    final detections = doc['detections'] as List;
    for (var detection in detections) {
      // Handle null and type issues by casting to int
      totalCredits += ((detection['credits'] ?? 0) as num).toInt();

    }
  }
  return totalCredits;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pickup Request'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                  if (_currentStep == 2) {
                    setState(() {
                      _showConfirmButton = true;
                    });
                  }
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text("Detection Results"),
                  content: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('pickupRequests')
                        .doc(widget.requestId)
                        .collection('results')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching data.'));
                      }
                      final data = snapshot.data?.docs;
                      if (data == null || data.isEmpty) {
                        return const Center(child: Text('No items detected.'));
                      }

                      _totalCredits = calculateTotalCredits(data);

                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              final detections = (item['detections'] as List)
                                  .map((d) =>
                                      '${d['class_name']} (Confidence: ${(d['confidence'] * 100).toStringAsFixed(2)}%, Credits: ${d['credits']})')
                                  .join('\n');
                              return Card(
                                child: ListTile(
                                  title: Text('Image: ${item['fileName']}'),
                                  subtitle: Text(detections),
                                ),
                              );
                            },
                          ),
                          Text('Total Credits: $_totalCredits',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      );
                    },
                  ),
                ),
                Step(
                  title: const Text("Enter Pickup Address"),
                  content: TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: "Pickup Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Step(
                  title: const Text("Schedule Pickup"),
                  content: Column(
                    children: [
                      ListTile(
                        title: Text("Selected Date: ${selectedDate.toLocal()}".split(' ')[0]),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () => _selectDate(context),
                      ),
                      ListTile(
                        title: Text("Selected Time: ${selectedTime.format(context)}"),
                        trailing: const Icon(Icons.access_time),
                        onTap: () => _selectTime(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showConfirmButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
   await _savePickupRequest();
   Navigator.push(
     context,
     MaterialPageRoute(
       builder: (context) => FinalPickupPage(
         requestId: widget.requestId,
         selectedDate: selectedDate,
         selectedTime: selectedTime,
         totalCredits: _totalCredits,
       ),
     ),
   );
},
                child: const Text("Confirm Pickup"),
              ),
            ),
        ],
      ),
    );
  }
}

class FinalPickupPage extends StatelessWidget {
  final String requestId;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
   final int totalCredits;
  const FinalPickupPage({
    required this.requestId,
    required this.selectedDate,
    required this.selectedTime,
    required this.totalCredits,
    Key? key,
  }) : super(key: key);

  String _getMonthName(int month) {
  const monthNames = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  return monthNames[month - 1];
}


void _showMapDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Close",
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                const MapPage(), // Embeds the MapPage
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
   @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pickup Request'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'Pickup request',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                   ListTile(
                    leading: const Icon(Icons.calendar_today, color: Colors.green),
                    title: Text("Scheduled Pickup Date: ${selectedDate.day} ${_getMonthName(selectedDate.month)} ${selectedDate.year}"),

                  ),
                  ListTile(
                    leading: const Icon(Icons.access_time, color: Colors.blue),
                    title: Text("Scheduled Pickup Time: ${selectedTime.format(context)}"),
                  ),
                    Divider(height: 20, color: Colors.grey.shade300),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.amber),
                        const SizedBox(width: 8),
                        const Text(
                          'Waiting to get assigned',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                        'Hang tight! Your request will be assigned by the scheduled date.'),
                    Divider(height: 20, color: Colors.grey.shade300),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey),
                        const SizedBox(width: 8),
                        const Text(
                          'Expected pickup',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('Saturday 25, Jan 2025'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pickupRequests')
                    .doc(requestId) // Filter by requestId
                    .collection('results') // Get the detection results for this request
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data.'));
                  }

                  final data = snapshot.data?.docs;

                  if (data == null || data.isEmpty) {
                    return const Center(child: Text('No items detected.'));
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      final detections = (item['detections'] as List)
                          .map((d) =>
                              '${d['class_name']} (Confidence: ${(d['confidence'] * 100).toStringAsFixed(2)}%)')
                          .join('\n');
                      return Card(
                        child: ListTile(
                          title: Text('Image: ${item['fileName']}'),
                          subtitle: Text(detections),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () => _showMapDialog(context), // Show the map dialog
                child: const Text(
                  'Track Delivery',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

