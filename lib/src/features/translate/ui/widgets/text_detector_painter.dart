import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:ai_translator/src/features/translate/ui/widgets/coordinates_translator.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognizerPainter extends CustomPainter {
  TextRecognizerPainter(
    this.blocks,
    this.translatedTexts,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<TextBlock> blocks;
  final List<String> translatedTexts;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = CupertinoColors.systemGrey6;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (final textBlock in blocks) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 10,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(ui.TextStyle(color: kTabFade1, background: background));
      builder.addText(textBlock.text);
      builder.pop();

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

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

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

        if (Platform.isAndroid) {
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
    return oldDelegate.translatedTexts != translatedTexts;
  }
}

class BoundingRectPainter extends CustomPainter {
  BoundingRectPainter(this.textBlocks, this.translatedTexts);

  final List<TextBlock> textBlocks;
  final List<String> translatedTexts;

  @override
  void paint(Canvas canvas, Size size) {
    if (textBlocks.isEmpty || translatedTexts.isEmpty) return;

    final Paint rectPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = CupertinoColors.systemGrey;

    final Paint textBackgroundPaint = Paint()..color = kTabFade1;

    final textStyle = ui.TextStyle(
      color: kBackgroundColor,
      background: textBackgroundPaint,
      fontSize: mediumTextSize,
      fontFamily: GoogleFonts.aBeeZee().fontFamily,
    );

    // Calculate a unified bounding rectangle that encompasses all textBlocks
    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    for (final block in textBlocks) {
      final rect = block.boundingBox;
      minX = rect.left < minX ? rect.left : minX;
      minY = rect.top < minY ? rect.top : minY;
      maxX = rect.right > maxX ? rect.right : maxX;
      maxY = rect.bottom > maxY ? rect.bottom : maxY;
    }

    // Draw the unified bounding rectangle
    final Rect unifiedRect = Rect.fromLTRB(minX, minY, maxX, maxY);
    canvas.drawRect(unifiedRect, rectPaint);

    // Combine all translated texts into a single string
    final String combinedText = translatedTexts.join('\n');

    // Draw the combined text inside the unified bounding rectangle
    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(
      ParagraphStyle(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      ),
    )
      ..pushStyle(textStyle)
      ..addText(combinedText);

    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(ParagraphConstraints(width: unifiedRect.width));

    canvas.drawParagraph(paragraph, Offset(unifiedRect.left, unifiedRect.top));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
