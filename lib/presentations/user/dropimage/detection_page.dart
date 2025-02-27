import 'package:ewaste/pages/credits.dart';
import 'package:ewaste/pages/pickupfinal.dart';
import 'package:ewaste/presentations/user/dropimage/services/pickupservice.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'services/api_service.dart';
import 'services/image_service.dart';
import 'widgets/processing_screen.dart';
import 'package:ewaste/pages/pickupfinal.dart'; // Ensure this is imported correctly

class DetectionPage extends StatefulWidget {
  @override
  _DetectionPageState createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  final ApiService _apiService = ApiService();
  List<File> _selectedImages = [];
  List<Map<String, dynamic>> _detectionResults = [];
  bool _isProcessing = false;

  Future<void> _pickImages() async {
    final images = await ImageService.pickImages();
    if (images.isNotEmpty) {
      setState(() => _selectedImages = images);
    }
  }

  Future<void> _sendImagesToBackend() async {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select images first.')),
      );
      return;
    }

    setState(() => _isProcessing = true);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(child: ProcessingScreen()),
    );

    try {
      final results =
          await _apiService.sendImagesToBackend(context, _selectedImages);
      setState(() => _detectionResults = results);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Detection completed!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      Navigator.pop(context);
      setState(() => _isProcessing = false);
    }
  }

  // Check if any e-waste is detected
  bool get _hasEWaste {
    return _detectionResults.any((result) {
      return (result['detections'] as List).any((d) =>
          d['class_name'].toString().toLowerCase().contains('ewaste'));
    });
  }
final PickupService _pickupService = PickupService();
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
  onPressed: () {
    _pickupService.requestPickup(
      context,
      _detectionResults,
      calculateTotalCredits,
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: const EdgeInsets.symmetric(vertical: 16),
  ),
  child: const Text('Request Pickup'),
),
          ],
        ),
      ),
    );
  }
}