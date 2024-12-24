import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:ai_translator/src/features/translate/ui/widgets/coordinates_translator.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      ..color = CupertinoColors.transparent;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (final textBlock in blocks) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 14.sp,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(ui.TextStyle(
        color: kTabFade1,
        background: background,
        fontSize: 14.sp,
      ));
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

class BoundingTextRecognizer extends CustomPainter {
  BoundingTextRecognizer(
    this.blocks,
    this.translatedTexts,
    this.imageSize,
  );

  final List<TextBlock> blocks;
  final List<String> translatedTexts;
  final Size imageSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = CupertinoColors.systemGrey6;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (int i = 0; i < blocks.length; i++) {
      final textBlock = blocks[i];
      final translatedText = translatedTexts[i];

      // Create a ParagraphBuilder to add the translated text
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 14.sp,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(ui.TextStyle(
        color: kTabFade1,
        background: background,
        fontSize: 14.sp,
      ));
      builder.addText(translatedText);
      builder.pop();

      // Translate the bounding box coordinates
      final left = textBlock.boundingBox.left / imageSize.width * size.width;
      final top = textBlock.boundingBox.top / imageSize.height * size.height;
      final right = textBlock.boundingBox.right / imageSize.width * size.width;
      final bottom =
          textBlock.boundingBox.bottom / imageSize.height * size.height;

      // Draw the bounding box around the text block
      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      // Draw the translated text inside the bounding box
      final Paragraph paragraph = builder.build()
        ..layout(ParagraphConstraints(width: (right - left).abs()));

      // Position the text inside the bounding box
      canvas.drawParagraph(
        paragraph,
        Offset(left, top),
      );
    }
  }

  @override
  bool shouldRepaint(TextRecognizerPainter oldDelegate) {
    return oldDelegate.translatedTexts != translatedTexts;
  }
}
