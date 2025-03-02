import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import '../../../../data/models/ewaste_item.dart';
import '../../../../data/models/selected_items_provider.dart';

class AIDetectionCard extends StatefulWidget {
  @override
  _AIDetectionCardState createState() => _AIDetectionCardState();
}

class _AIDetectionCardState extends State<AIDetectionCard> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  List<EWasteItem> _detectedItems = [];
  bool _isLoading = false;

  // Pick multiple images
  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages = images.map((file) => File(file.path)).toList();
      });
    }
  }

  // Compress image before sending to the server
  Future<File> _compressImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes);
    if (originalImage == null) return imageFile;

    final compressedImage = img.encodeJpg(originalImage, quality: 85);
    final compressedFile = File(imageFile.path)
      ..writeAsBytesSync(compressedImage);

    return compressedFile;
  }

  // Send images to the backend and process results
  Future<void> _detectObjects() async {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please upload images first")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _detectedItems.clear();
    });

    var provider = Provider.of<SelectedItemsProvider>(context, listen: false);
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://https://66de-34-106-156-87.ngrok-free.app//predict"));

    try {
      for (var image in _selectedImages) {
        final compressedImage = await _compressImage(image);
        request.files.add(await http.MultipartFile.fromPath("images", compressedImage.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var jsonResponse = jsonDecode(response.body);

      Map<String, int> detectedCounts = {};

      for (var detection in jsonResponse) {
        for (var item in detection["detections"]) {
          String className = item["class_name"];
          detectedCounts[className] = (detectedCounts[className] ?? 0) + 1;
        }
      }

      List<EWasteItem> newDetectedItems = [];
      detectedCounts.forEach((name, count) {
        var item = EWasteItem(
          name: name,
          category: "AI Detected",
          baseCredit: _getCreditsForItem(name),
          count: count,
        );
        newDetectedItems.add(item);
        provider.addItem(item);
      });

      setState(() {
        _detectedItems = newDetectedItems;
      });

    } catch (e) {
      print("AI Detection Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("AI detection failed")),
      );
    }

    setState(() => _isLoading = false);
  }

  int _getCreditsForItem(String itemName) {
    Map<String, int> creditMapping = {
      "Laptop": 600,
      "Computer-Mouse": 90,
    };
    return creditMapping[itemName] ?? 50;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AI Detection", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // Display uploaded images
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedImages.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(image, width: 60, height: 60, fit: BoxFit.cover),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // Upload & Detect buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickImages,
                    icon: Icon(Icons.upload),
                    label: Text("Upload Images"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _detectObjects,
                    icon: Icon(Icons.search),
                    label: _isLoading ? CircularProgressIndicator() : Text("Detect Objects"),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            // Show detected items
            if (_detectedItems.isNotEmpty) ...[
              Text("Detected Items", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _detectedItems.length,
                itemBuilder: (context, index) {
                  final item = _detectedItems[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.devices, color: Colors.green),
                      title: Text(item.name),
                      subtitle: Text("Count: ${item.count} - Credits: ${item.baseCredit}"),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
