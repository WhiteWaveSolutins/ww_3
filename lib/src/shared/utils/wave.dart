import 'package:flutter/cupertino.dart';

class AnimatedWave extends StatefulWidget {
  const AnimatedWave({super.key});

  @override
  State<AnimatedWave> createState() => _AnimatedWaveState();
}

class _AnimatedWaveState extends State<AnimatedWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: AnimatedWavePainter(_controller.value),
          size: const Size(double.infinity, 259),
        );
      },
    );
  }
}

/// The AnimatedWavePainter animates the SVG paths.
class AnimatedWavePainter extends CustomPainter {
  final double animationValue;

  AnimatedWavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Wave 1
    paint.color = const Color(0xFF2B86FF).withOpacity(0.1);
    canvas.drawPath(wave1Path(animationValue), paint);

    // Wave 2
    paint.color = const Color(0xFF4B40FF).withOpacity(0.25);
    canvas.drawPath(wave2Path(animationValue), paint);

    // Wave 3
    paint.color = const Color(0xFF781FEC).withOpacity(0.4);
    canvas.drawPath(wave3Path(animationValue), paint);

    // Wave 4
    paint.color = const Color(0xFF7413B1).withOpacity(0.55);
    canvas.drawPath(wave4Path(animationValue), paint);

    // Wave 5
    paint.color = const Color(0xFF9437C7).withOpacity(0.7);
    canvas.drawPath(wave5Path(animationValue), paint);

    // Wave 6
    paint.color = const Color(0xFFF026E7).withOpacity(0.85);
    canvas.drawPath(wave6Path(animationValue), paint);

    // Final Path
    paint.color = const Color(0xFF9437C7);
    paint.strokeWidth = 10;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(finalWavePath(animationValue), paint);
  }

  /// Each function below corresponds to one of the paths, animated by the animation value.

  Path wave1Path(double value) {
    Path path = Path();
    path.moveTo(-303.596 + 50 * value, 129.5); // Horizontal shift
    path.cubicTo(
      -267.3 + 50 * value,
      129.5,
      -227.924 + 50 * value,
      163.886,
      -172.597 + 50 * value,
      163.886,
    );
    path.cubicTo(
      -94.921 + 50 * value,
      163.886,
      -42.7571 + 50 * value,
      54.4807,
      66.1355 + 50 * value,
      54.4807,
    );
    path.cubicTo(
      152.129 + 50 * value,
      54.4807,
      253.667 + 50 * value,
      198.385,
      348.195 + 50 * value,
      198.385,
    );
    path.cubicTo(
      416.112 + 50 * value,
      198.385,
      472.675 + 50 * value,
      124.861,
      543.89 + 50 * value,
      119.417,
    );
    path.cubicTo(
      566.048 + 50 * value,
      117.481,
      585.404 + 50 * value,
      127.458,
      607.596 + 50 * value,
      129.5,
    );
    return path;
  }

  Path wave2Path(double value) {
    Path path = Path();
    path.moveTo(-303.596 + 40 * value, 129.5);
    path.cubicTo(
      -267.3 + 40 * value,
      129.5,
      -228.691 + 40 * value,
      159.382,
      -173.364 + 40 * value,
      159.382,
    );
    path.cubicTo(
      -89.9322 + 40 * value,
      159.382,
      -56.5078 + 40 * value,
      62.6995,
      59.6344 + 40 * value,
      62.6995,
    );
    path.cubicTo(
      135.821 + 40 * value,
      62.6995,
      243.014 + 40 * value,
      191.92,
      343.141 + 40 * value,
      191.92,
    );
    path.cubicTo(
      395.495 + 40 * value,
      191.92,
      455.79 + 40 * value,
      123.725,
      534.467 + 40 * value,
      118.068,
    );
    path.cubicTo(
      556.625 + 40 * value,
      116.069,
      574.625 + 40 * value,
      124.45,
      607.596 + 40 * value,
      129.5,
    );
    return path;
  }

  Path wave3Path(double value) {
    Path path = Path();
    path.moveTo(-303.596 + 30 * value, 129.5);
    path.cubicTo(
      -267.3 + 30 * value,
      129.5,
      -227.995 + 30 * value,
      155.126,
      -172.668 + 30 * value,
      155.126,
    );
    path.cubicTo(
      -89.2356 + 30 * value,
      155.126,
      -69.168 + 30 * value,
      70.1458,
      46.9743 + 30 * value,
      70.1458,
    );
    path.cubicTo(
      123.161 + 30 * value,
      70.1458,
      233.845 + 30 * value,
      185.187,
      321.539 + 30 * value,
      184.965,
    );
    path.cubicTo(
      380.715 + 30 * value,
      184.824,
      436.658 + 30 * value,
      121.962,
      520.449 + 30 * value,
      115.738,
    );
    path.cubicTo(
      537.193 + 30 * value,
      113.654,
      567.376 + 30 * value,
      122.153,
      607.596 + 30 * value,
      129.5,
    );
    return path;
  }

  Path wave4Path(double value) {
    Path path = Path();
    path.moveTo(-303.596 + 20 * value, 129.5);
    path.cubicTo(
      -267.3 + 20 * value,
      129.5,
      -230.716 + 20 * value,
      151.093,
      -175.389 + 20 * value,
      151.093,
    );
    path.cubicTo(
      -91.9567 + 20 * value,
      151.093,
      -75.3449 + 20 * value,
      77.9465,
      40.7947 + 20 * value,
      77.4904,
    );
    path.cubicTo(
      113.531 + 20 * value,
      77.1572,
      214.422 + 20 * value,
      179.324,
      302.107 + 20 * value,
      178.601,
    );
    path.cubicTo(
      364.512 + 20 * value,
      178.045,
      419.13 + 20 * value,
      120.107,
      502.924 + 20 * value,
      114.451,
    );
    path.cubicTo(
      525.082 + 20 * value,
      112.452,
      566.523 + 20 * value,
      124.365,
      607.596 + 20 * value,
      129.5,
    );
    return path;
  }

  Path wave5Path(double value) {
    Path path = Path();
    path.moveTo(-303.596 + 10 * value, 129.5);
    path.cubicTo(
      -274.123 + 10 * value,
      129.5,
      -235.289 + 10 * value,
      147.389,
      -179.962 + 10 * value,
      147.416,
    );
    path.cubicTo(
      -96.0184 + 10 * value,
      147.459,
      -85.5627 + 10 * value,
      85.851,
      30.5769 + 10 * value,
      85.3949,
    );
    path.cubicTo(
      103.313 + 10 * value,
      85.0617,
      195.5 + 10 * value,
      173.341,
      283.184 + 10 * value,
      172.329,
    );
    path.cubicTo(
      348.573 + 10 * value,
      171.561,
      403.535 + 10 * value,
      117.234,
      487.328 + 10 * value,
      111.577,
    );
    path.cubicTo(
      509.487 + 10 * value,
      109.578,
      568.826 + 10 * value,
      126.577,
      607.596 + 10 * value,
      129.5,
    );
    return path;
  }

  Path wave6Path(double value) {
    Path path = Path();
    path.moveTo(-303.596, 129.5);
    path.cubicTo(
      -273.952 + 5 * value,
      129.5,
      -239.078 + 5 * value,
      144.374,
      -183.757 + 5 * value,
      143.775,
    );
    path.cubicTo(
      -97.4249 + 5 * value,
      142.796,
      -94.8352 + 5 * value,
      92.9664,
      21.3044 + 5 * value,
      92.5102,
    );
    path.cubicTo(
      94.0407 + 5 * value,
      92.1771,
      173.497 + 5 * value,
      167.337,
      261.175 + 5 * value,
      166.14,
    );
    path.cubicTo(
      331.683 + 5 * value,
      165.039,
      382.279 + 5 * value,
      116.05,
      466.072 + 5 * value,
      110.393,
    );
    path.cubicTo(
      488.231 + 5 * value,
      108.394,
      561.747 + 5 * value,
      126.917,
      607.596 + 5 * value,
      129.5,
    );
    return path;
  }

  Path finalWavePath(double value) {
    Path path = Path();
    path.moveTo(-356.035 + 60 * value, 129.5);
    path.cubicTo(-356.035, 129.5, -309.437, 129.5, -303.596, 129.5);
    path.cubicTo(-291.741, 129.5, -278.576, 135.17, -249.45, 137.812);
    path.cubicTo(-208.554, 141.544, -168.277, 140.229, -149.336, 134.94);
    path.cubicTo(-89.2537, 118.16, -66.3247, 100.865, -13.7518, 99.4063);
    path.cubicTo(16.4646, 98.556, 52.3255, 104.403, 101.58, 123.447);
    path.cubicTo(137.558, 137.356, 185.022, 155.449, 213.689, 157.965);
    path.cubicTo(254.469, 161.543, 293.012, 156.039, 328.005, 143.033);
    path.cubicTo(359.096, 131.479, 403.346, 111.873, 427.216, 109.715);
    path.cubicTo(459.963, 106.766, 491.192, 112.908, 523.192, 119.313);
    path.cubicTo(548.886, 124.47, 576.618, 129.5, 607.596, 129.5);
    path.lineTo(652.247, 129.5);
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint on every animation frame
  }
}
