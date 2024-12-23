import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'coordinates_translator.dart';

class TextRecognizerPainter extends CustomPainter {
  TextRecognizerPainter(
    this.textBlocks,
    this.translatedTexts,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<TextBlock> textBlocks;
  final List<String> translatedTexts;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = CupertinoColors.systemGrey.withOpacity(0.3);

    final Paint background = Paint()..color = kTabFade1.withOpacity(0.4);

    for (int i = 0; i < textBlocks.length; i++) {
      final textBlock = textBlocks[i];
      final translatedText = translatedTexts[i];

      // Build translated text as a Paragraph
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 16,
          textDirection: TextDirection.ltr,
        ),
      );
      builder.pushStyle(ui.TextStyle(
          color: kBackgroundColor,
          background: background,
          fontSize: mediumTextSize,
          fontFamily: GoogleFonts.aBeeZee().fontFamily));
      builder.addText(translatedText);
      builder.pop();

      // Translate bounding box coordinates
      final left = translateX(
        textBlock.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        textBlock.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        textBlock.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        textBlock.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      // Draw bounding box
      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);

      // Translate corner points for polygons
      final List<Offset> cornerPoints = <Offset>[];
      for (final point in textBlock.cornerPoints) {
        double x = translateX(
          point.x.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );
        double y = translateY(
          point.y.toDouble(),
          size,
          imageSize,
          rotation,
          cameraLensDirection,
        );

        if (Platform.isIOS) {
          switch (cameraLensDirection) {
            case CameraLensDirection.front:
              switch (rotation) {
                case InputImageRotation.rotation0deg:
                case InputImageRotation.rotation90deg:
                  break;
                case InputImageRotation.rotation180deg:
                  x = size.width - x;
                  y = size.height - y;
                  break;
                case InputImageRotation.rotation270deg:
                  x = translateX(
                    point.y.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  );
                  y = size.height -
                      translateY(
                        point.x.toDouble(),
                        size,
                        imageSize,
                        rotation,
                        cameraLensDirection,
                      );
                  break;
              }
              break;
            case CameraLensDirection.back:
              switch (rotation) {
                case InputImageRotation.rotation0deg:
                case InputImageRotation.rotation270deg:
                  break;
                case InputImageRotation.rotation180deg:
                  x = size.width - x;
                  y = size.height - y;
                  break;
                case InputImageRotation.rotation90deg:
                  x = size.width -
                      translateX(
                        point.y.toDouble(),
                        size,
                        imageSize,
                        rotation,
                        cameraLensDirection,
                      );
                  y = translateY(
                    point.x.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  );
                  break;
              }
              break;
            case CameraLensDirection.external:
              break;
          }
        }

        cornerPoints.add(Offset(x, y));
      }

      // Add the first point to close the polygon
      cornerPoints.add(cornerPoints.first);
      canvas.drawPoints(PointMode.polygon, cornerPoints, paint);

      // Draw translated text
      canvas.drawParagraph(
        builder.build()
          ..layout(ParagraphConstraints(
            width: (right - left).abs(),
          )),
        Offset(
            Platform.isAndroid &&
                    cameraLensDirection == CameraLensDirection.front
                ? right
                : left,
            top),
      );
    }
  }

  @override
  bool shouldRepaint(TextRecognizerPainter oldDelegate) {
    return oldDelegate.textBlocks != textBlocks ||
        oldDelegate.translatedTexts != translatedTexts;
  }
}

class BoundingRectPainter extends CustomPainter {
  BoundingRectPainter(this.textBlocks, this.translatedTexts);

  final List<TextBlock> textBlocks;
  final List<String> translatedTexts;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint rectPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = CupertinoColors.systemGrey;

    final Paint textBackgroundPaint = Paint()..color = const Color(0x99000000);

    final textStyle = ui.TextStyle(
      color: CupertinoColors.white,
      fontSize: 14,
      background: textBackgroundPaint,
    );

    for (int i = 0; i < textBlocks.length; i++) {
      final block = textBlocks[i];
      final rect = block.boundingBox;

      // Draw bounding rectangle
      canvas.drawRect(
        Rect.fromLTWH(
          rect.left,
          rect.top,
          rect.width,
          rect.height,
        ),
        rectPaint,
      );

      // Draw translated text
      final translatedText =
          i < translatedTexts.length ? translatedTexts[i] : '';
      final paragraphBuilder = ParagraphBuilder(
        ParagraphStyle(
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        ),
      )
        ..pushStyle(textStyle)
        ..addText(translatedText);

      final paragraph = paragraphBuilder.build()
        ..layout(ParagraphConstraints(width: rect.width));

      canvas.drawParagraph(paragraph, Offset(rect.left, rect.top));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
