import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectionPage1 extends StatefulWidget {
  @override
  _DetectionPage1State createState() => _DetectionPage1State();
}

class _DetectionPage1State extends State<DetectionPage1> {
  final List<File> _selectedImages = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Object Detection')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _selectedImages.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.file(_selectedImages[index], fit: BoxFit.cover, width: 200),
                  );
                },
              ),
            )
                : Placeholder(fallbackHeight: 200),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Select Images'),
            ),
            const SizedBox(height: 16),
       
          ],
        ),
      ),
    );
  }
}
