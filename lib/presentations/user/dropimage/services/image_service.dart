import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<File> compressImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final originalImage = img.decodeImage(bytes)!;
    final compressedImage = img.encodeJpg(originalImage, quality: 85);
    final compressedFile = File(imageFile.path)
      ..writeAsBytesSync(compressedImage);
    return compressedFile;
  }

  static Future<List<File>> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles == null || pickedFiles.isEmpty) {
      return [];
    }

    return pickedFiles.map((file) => File(file.path)).toList();
  }
}
