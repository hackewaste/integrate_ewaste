import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For File handling
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image/image.dart' as img;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewaste/pages/pickupfinal.dart';
import 'credits.dart';


class DropImagePage extends StatefulWidget {
  const DropImagePage({super.key});

  
  @override
  State<DropImagePage> createState() => _DropImagePageState();
}

class _DropImagePageState extends State<DropImagePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Drop an Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Container Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How you can\nEarn reward for\nRecycling',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'With you we will help ecology',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Add functionality here for My Waste Pickup
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Waste pick up',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.recycling, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // More Services Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'More services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Add functionality for "see more"
                  },
                  child: const Text(
                    'see more',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Services Icons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ServiceIcon( 
                  icon: Icons.local_shipping,
                  label: 'Pick waste',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  DetectionPage()),
                    );
                  },
                ),
                ServiceIcon(
                  icon: Icons.attach_money,
                  label: 'Get money',
                  onPressed: () {
                    // Add functionality for "Get money"
                  },
                ),
                ServiceIcon(
                  icon: Icons.recycling,
                  label: 'Recycling',
                  onPressed: () {
                    // Add functionality for "Recycling"
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Service Icons
class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ServiceIcon({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// Upload Waste Page
class DetectionPage extends StatefulWidget {
  @override
  _DetectionPageState createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  final List<File> _selectedImages = [];
  final List<Map<String, dynamic>> _detectionResults = []; // Updated type
  bool _isProcessing = false;

  // Compress an image

  // Pick multiple images from the gallery
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.clear();
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }
  Future<File> compressImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes)!;
    final compressedImage = img.encodeJpg(originalImage, quality: 85);
    final compressedFile = File(imageFile.path)
      ..writeAsBytesSync(compressedImage);
    return compressedFile;
  }

  // Send the images to the backend
  // Send the images to the backend
Future<void> _sendImagesToBackend() async {
  if (_selectedImages.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select images first.')),
    );
    return;
  }

  try {
    setState(() {
      _isProcessing = true;
      _detectionResults.clear();
    });

    final url = Uri.parse('https://ca47-34-48-156-24.ngrok-free.app/predict');
    final request = http.MultipartRequest('POST', url);

    // Compress and attach images
    for (var image in _selectedImages) {
      final compressedImage = await compressImage(image);
      request.files.add(
        await http.MultipartFile.fromPath('images', compressedImage.path),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseBody);

      // Map to track item counts
      Map<String, int> detectedItems = {};

      // Process detection results
      final List<Map<String, dynamic>> processedResults = jsonResponse.map<Map<String, dynamic>>((result) {
        final fileName = result['file_name'];
        final detections = result['detections'] as List;

        for (var detection in detections) {
          String category = detection['class_name'];
          detectedItems[category] = (detectedItems[category] ?? 0) + 1;
        }

        return {
          'fileName': fileName,
          'detections': detections,
        };
      }).toList();

      // Calculate credits
      int totalCredits = calculateTotalCredits(detectedItems);

      // Add credits to detection results
      for (var result in processedResults) {
        for (var detection in result['detections']) {
          String category = detection['class_name'];
          detection['credits'] = ewasteCredits[category] ?? 0; // Assign credits
        }
      }

      setState(() {
        _detectionResults.addAll(processedResults);
      });

      // Show total credits earned
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You earned $totalCredits credits!')),
      );

    } else {
      setState(() {
        _detectionResults.add({'error': 'Error: ${response.reasonPhrase}'});
      });
    }
  } catch (e) {
    setState(() {
      _detectionResults.add({'error': 'Error connecting to backend: $e'});
    });
  } finally {
    setState(() {
      _isProcessing = false;
    });
  }
}


  // Store detection results in Firebase and navigate to PickupRequestPage
  Future<void> _requestPickup() async {
  if (_detectionResults.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No results to request pickup.')),
    );
    return;
  }

  try {
    final firestore = FirebaseFirestore.instance;
    final requestId = firestore.collection('pickupRequests').doc().id; // Generate unique ID

      await firestore.collection('pickupRequests').doc(requestId).set({
      'status': 'pending',  // Can be used to track pickup request status
      'created_at': FieldValue.serverTimestamp(),
    });
    // Convert detection results into required format for credit calculation
    Map<String, int> detectedItems = {};

    for (var result in _detectionResults) {
      for (var detection in result['detections']) {
        String category = detection['class_name'];

        // Increment count for each detected category
        if (detectedItems.containsKey(category)) {
          detectedItems[category] = detectedItems[category]! + 1;
        } else {
          detectedItems[category] = 1;
        }
      }
    }

    // Calculate total credits
    int totalCredits = calculateTotalCredits(detectedItems);

    for (var result in _detectionResults) {
      await firestore.collection('pickupRequests').doc(requestId).collection('results').add({
        'fileName': result['fileName'],
        'detections': result['detections'],
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    // Store total credits in Firestore
      await firestore.collection('pickupRequests').doc(requestId).set({
      'totalCredits': totalCredits,
    }, SetOptions(merge: true));

    // Navigate to PickupRequestPage with the request ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickupRequestPage(requestId: requestId),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to store results: $e')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Object Detection')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_selectedImages.isNotEmpty)
              CarouselSlider(
                items: _selectedImages
                    .map((image) => Image.file(image, fit: BoxFit.cover))
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                ),
              )
            else
              Placeholder(fallbackHeight: 200),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Select Images'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isProcessing ? null : _sendImagesToBackend,
              child: _isProcessing
                  ? const CircularProgressIndicator()
                  : const Text('Detect Objects'),
            ),
            const SizedBox(height: 16),
            if (_detectionResults.isNotEmpty)
  Expanded(
    child: ListView.builder(
      itemCount: _detectionResults.length,
      itemBuilder: (context, index) {
        final result = _detectionResults[index];
        final detections = (result['detections'] as List).map((d) {
          int credits = d['credits'] ?? 0;
          return '${d['class_name']} (Confidence: ${(d['confidence'] * 100).toStringAsFixed(2)}%) - Credits: $credits';
        }).join('\n');

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Image: ${result['fileName']}\n$detections',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    ),
  ),
            const SizedBox(height: 16),
            if (_detectionResults.isNotEmpty)
              ElevatedButton(
                onPressed: _requestPickup, // Trigger request pickup logic
                child: const Text('Request Pickup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
