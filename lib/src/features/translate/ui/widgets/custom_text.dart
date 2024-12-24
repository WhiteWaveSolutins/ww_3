import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:flutter/cupertino.dart';

class TextBubblePainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;

  TextBubblePainter({
    required this.borderColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ));

    // Draw background bubble
    canvas.drawPath(path, paint);

    // Draw dashed border
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0;
    final borderPath = Path();
    while (startX < size.width) {
      borderPath.moveTo(startX, 0);
      borderPath.lineTo(startX + dashWidth, 0);
      startX += dashWidth + dashSpace;
    }

    startX = 0;
    while (startX < size.height) {
      borderPath.moveTo(0, startX);
      borderPath.lineTo(0, startX + dashWidth);
      startX += dashWidth + dashSpace;
    }

    startX = 0;
    while (startX < size.width) {
      borderPath.moveTo(startX, size.height);
      borderPath.lineTo(startX + dashWidth, size.height);
      startX += dashWidth + dashSpace;
    }

    startX = 0;
    while (startX < size.height) {
      borderPath.moveTo(size.width, startX);
      borderPath.lineTo(size.width, startX + dashWidth);
      startX += dashWidth + dashSpace;
    }

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CustomTextBubble extends StatelessWidget {
  final String text;

  const CustomTextBubble({
    required this.text,
    super.key,
    this.fontSize,
  });
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TextBubblePainter(
          borderColor: kTabFade1.withOpacity(0.5),
          backgroundColor: kBackgroundColor.withOpacity(0.5)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: smallHorizontalPadding, vertical: smallVerticalPadding),
        child: Text(
          text,
          style: context.bodyLarge.copyWith(fontSize: fontSize),
          textAlign: TextAlign.start,
          softWrap: true,
        ),
      ),
    );
  }
}
