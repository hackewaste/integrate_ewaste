import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PickupConfirmationPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VolunteerApp());
}

class VolunteerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VolunteerDashboard(),
    );
  }
}

class VolunteerDashboard extends StatefulWidget {
  @override
  _VolunteerDashboardState createState() => _VolunteerDashboardState();
}

class _VolunteerDashboardState extends State<VolunteerDashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> acceptRequest(String requestId, String userId, int credits) async {
  try {
    // Update the request status and assign volunteer
    await _firestore.collection('usertemporary').doc(requestId).update({
      'volunteerId': 'demo_volunteer_123', // Should be dynamic
      'status': 'scheduled', // Mark as scheduled
    });

    // Create a notification for the user
    await _firestore.collection('notifications').add({
      'userId': userId,
      'message': 'Your pickup request has been accepted by a volunteer!',
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request Accepted! User Notified.")),
    );

    // Navigate to PickupConfirmationPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickupConfirmationPage(
          requestId: requestId,
          userId: userId,
          credits: credits, // Pass the credits
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Dashboard'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('usertemporary')
            .where('volunteerId', isNull: true) // ✅ Corrected Firestore query
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No pending pickup requests'));
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final requestId = request.id;
              final data = request.data() as Map<String, dynamic>? ?? {}; // ✅ Ensures it's a Map

              final userId = data.containsKey('uid') ? data['uid'] : 'unknown_user';
              final address = data.containsKey('address') ? data['address'] : 'Unknown Address';
              final scheduledDate = data.containsKey('scheduledDate') ? data['scheduledDate'] : 'Unknown Date';
              final scheduledTime = data.containsKey('scheduledTime') ? data['scheduledTime'] : 'Unknown Time';
              final credits = data.containsKey('credits') ? data['credits'] : 0; // ✅ Fix: Extract credits

              return Card(
                child: ListTile(
                  title: Text('Pickup at: $address'),
                  subtitle: Text('Date: $scheduledDate | Time: $scheduledTime'),
                  trailing: ElevatedButton(
  onPressed: () => acceptRequest(requestId, userId, credits), // ✅ Pass credits
  child: Text('Accept'),
),

                ),
              );
            },
          );
        },
      ),
    );
  }
}
