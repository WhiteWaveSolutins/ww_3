import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageMixin {
  static Future<File?> pickImage(
      {ImageSource source = ImageSource.gallery}) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: source == ImageSource.camera ? 55 : 90,
      );

      if (image == null) {
        return null;
      }
      return File(image.path);
    } catch (e) {
      return null;
    }
  }
}
