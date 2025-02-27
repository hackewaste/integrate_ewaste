
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'image_service.dart';

class ApiService {
  Future<List<Map<String, dynamic>>> sendImagesToBackend(
      BuildContext context, List<File> selectedImages) async {
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select images first.')),
      );
      return [];
    }
    try {
      final url = Uri.parse('https://53b1-104-197-58-236.ngrok-free.app/predict');
      final request = http.MultipartRequest('POST', url);

      for (var image in selectedImages) {
        final compressedImage = await ImageService.compressImage(image);
        request.files.add(await http.MultipartFile.fromPath(
            'images', compressedImage.path));
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        return List<Map<String, dynamic>>.from(jsonDecode(responseBody));
      } else {
        throw Exception('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error connecting to backend: $e');
    }
  }
}
