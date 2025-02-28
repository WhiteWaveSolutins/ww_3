import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/utils/theme.dart';
import 'coordinates_translator.dart';
import 'custom_text.dart';

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
    for (var i = 0; i < blocks.length; i++) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
            textAlign: TextAlign.left,
            fontSize: 14,
            textDirection: TextDirection.ltr),
      );
      builder.pushStyle(ui.TextStyle(
        color: kTabFade1,
        background: background,
        fontSize: 14,
      ));
      builder.addText(translatedTexts[i]);
      builder.pop();

      final left = translateX(
        blocks[i].boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        blocks[i].boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        blocks[i].boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      // final bottom = translateY(
      //   textBlock.boundingBox.bottom,
      //   size,
      //   imageSize,
      //   rotation,
      //   cameraLensDirection,
      // );

      // canvas.drawRect(
      //   Rect.fromLTRB(left, top, right, bottom),
      //   paint,
      // );

      final List<Offset> cornerPoints = <Offset>[];
      for (final point in blocks[i].cornerPoints) {
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
    return false;
  }
}

class TextOverlay extends StatelessWidget {
  final List<TextBlock> blocks;
  final List<String> translatedTexts;
  final Size imageSize;

  const TextOverlay({
    required this.blocks,
    required this.translatedTexts,
    required this.imageSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Adjust translated texts to match the number of text blocks
    final adjustedTranslatedTexts =
        _adjustTranslatedTexts(translatedTexts, blocks.length);

    // Adjust positions to avoid overlap
    // final adjustedBlocks = _adjustBlockPositions(blocks);

    return Center(
      child: CustomTextBubble(
        text: adjustedTranslatedTexts.join('\n\n'),
        fontSize: smallTextSize,
      ),
    );
    // Stack(
    //   children: [
    //     // Position each text block
    //     // ...adjustedBlocks.asMap().entries.map((entry) {
    //     //   final index = entry.key;
    //     //   final block = entry.value;
    //     //   const scaleLeft = 0.6;
    //     //   const scaleTop = 0.1;

    //     //   // Scale bounding box coordinates
    //     //   final left = block.boundingBox.left > imageSize.width
    //     //       ? block.boundingBox.left * 0.05
    //     //       : block.boundingBox.left * scaleLeft;
    //     //   final top = block.boundingBox.top > imageSize.height
    //     //       ? block.boundingBox.top * 0.4
    //     //       : block.boundingBox.top * scaleTop;

    //     //   return Positioned(
    //     //     left: left,
    //     //     top: top,
    //     //     child: Container(
    //     //       padding: EdgeInsets.symmetric(
    //     //           horizontal: smallHorizontalPadding,
    //     //           vertical: smallVerticalPadding),
    //     //       height: 50.h,
    //     //       alignment: Alignment.centerLeft,
    //     //       child: CustomTextBubble(
    //     //         text: adjustedTranslatedTexts[index],
    //     //         fontSize: adjustedTranslatedTexts[index].length > 30
    //     //             ? 9.sp
    //     //             : textSize,
    //     //       ),
    //     //     ),
    //     //   );
    //     // }),
    //   ],
    // );
  }

  // Method to adjust positions to avoid overlap
  // List<TextBlock> _adjustBlockPositions(List<TextBlock> blocks) {
  //   final adjustedBlocks = List<TextBlock>.from(blocks);

  //   for (int i = 0; i < adjustedBlocks.length; i++) {
  //     for (int j = i + 1; j < adjustedBlocks.length; j++) {
  //       final blockA = adjustedBlocks[i];
  //       final blockB = adjustedBlocks[j];

  //       final deltaLeft =
  //           (blockA.boundingBox.left - blockB.boundingBox.left).abs();
  //       final deltaTop =
  //           (blockA.boundingBox.top - blockB.boundingBox.top).abs();

  //       if (deltaLeft < 30 && deltaTop < 30) {
  //         // Adjust blockB's position to avoid overlap
  //         final newTop = blockB.boundingBox.top - 30;
  //         final newLeft = blockB.boundingBox.left - 100;

  //         adjustedBlocks[j] = TextBlock(
  //           cornerPoints: adjustedBlocks[j].cornerPoints,
  //           lines: adjustedBlocks[j].lines,
  //           recognizedLanguages: adjustedBlocks[j].recognizedLanguages,
  //           boundingBox: Rect.fromLTWH(
  //             newLeft,
  //             newTop,
  //             blockB.boundingBox.width,
  //             blockB.boundingBox.height,
  //           ),
  //           text: blockB.text,
  //         );
  //       }
  //     }
  //   }

  //   return adjustedBlocks;
  // }

  // Method to adjust the translated texts list
  List<String> _adjustTranslatedTexts(List<String> texts, int blockLength) {
    if (texts.length <= blockLength) {
      return texts; // No adjustment needed
    }

    // Merge the last two texts if the translated list is longer
    final mergedTexts = List<String>.from(texts);
    while (mergedTexts.length > blockLength) {
      final lastText = mergedTexts.removeLast();
      mergedTexts[mergedTexts.length - 1] += '  ${lastText.split(' ')}';
    }

    return mergedTexts;
  }
}
