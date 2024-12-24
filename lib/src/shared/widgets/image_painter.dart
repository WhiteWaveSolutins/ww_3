import 'dart:io';
import 'dart:ui' as ui;

import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ImageTextPainter extends CustomPainter {
  final ui.Image image;
  final List<TextBlock> textBlocks;
  final List<String> translations;
  final BuildContext context;

  ImageTextPainter(
      this.image, this.textBlocks, this.translations, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Scale factor for resizing
    final double scaleX = size.width / image.width;
    final double scaleY = size.height / image.height;

    // Draw the image scaled to fit the canvas
    final imageRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      imageRect,
      paint,
    );

    // Draw each text block with a background and translated text
    for (int i = 0; i < textBlocks.length; i++) {
      final block = textBlocks[i];
      final translatedText = (i < translations.length) ? translations[i] : '';

      // Scale the bounding box to match the canvas size
      final rect = Rect.fromLTRB(
        block.boundingBox.left * scaleX,
        block.boundingBox.top * scaleY,
        block.boundingBox.right * scaleX,
        block.boundingBox.bottom * scaleY,
      );

      // Draw background rectangle
      final backgroundPaint = Paint()..color = const Color(0xAA000000);
      canvas.drawRect(rect, backgroundPaint);

      // Draw translated text
      final textPainter = TextPainter(
        text: TextSpan(text: translatedText, style: context.bodyLarge),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: rect.width);

      // Calculate the position to center the text vertically within the rect
      final textOffset = Offset(
        rect.left + (rect.width - textPainter.width) / 2,
        rect.top + (rect.height - textPainter.height) / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Helper to load the image
Future<ui.Image> loadImage(File file) async {
  final bytes = await file.readAsBytes();
  final codec = await ui.instantiateImageCodec(bytes);
  final frameInfo = await codec.getNextFrame();
  return frameInfo.image;
}
