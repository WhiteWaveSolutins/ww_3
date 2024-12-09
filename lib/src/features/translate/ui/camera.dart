import 'dart:math';

import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter/material.dart';

class RecordingScreen extends StatefulWidget {
  // static const routeName = '/';
  const RecordingScreen({super.key});

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
      appBar: CupertinoNavigationBar(
        leading: const AppbackButton(),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.restorablePushNamed(
                  context, TranslatorSettingsScreen.routeName);
            },
            child: const Icon(CupertinoIcons.settings)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Language Selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainActionButton(
                  language: "English",
                  icon: sUsa,
                ),
                const SwapIcon(),
                MainActionButton(
                  language: "French",
                  icon: sFrance,
                ),
              ],
            ),
          ),
          // Text Prompt
          const Column(
            children: [
              Text(
                "Hello! Please explain this word",
                style: TextStyle(
                  color: kTabFade1,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // Wave Animation
          SizedBox(
            height: 150,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(_animationController.value),
                  child: Container(),
                );
              },
            ),
          ),
          // Pulsing Microphone
          Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  width: 105.h + (_animationController.value * 20),
                  height: 105.h + (_animationController.value * 20),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, gradient: kPrimaryGradient),
                  child: Container(
                    width: 100.h + (_animationController.value * 20),
                    height: 100.h + (_animationController.value * 20),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, gradient: kPrimaryGradient),
                    child: Container(
                        width: 90.h + (_animationController.value * 20),
                        height: 90.h + (_animationController.value * 20),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, gradient: kPrimaryGradient),
                        child: SvgPicture.asset(sMic)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class SwapIcon extends StatelessWidget {
  const SwapIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(sSwap);
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wavePaint = Paint()
      ..color = CupertinoColors.systemPink
      ..style = PaintingStyle.fill;

    final Path path = Path();
    const double waveHeight = 20.0;
    final double waveLength = size.width / 2;

    path.moveTo(0, size.height / 2);

    for (double i = 0; i <= size.width; i++) {
      double y = size.height / 2 +
          sin((i / waveLength * 2 * pi) + (animationValue * 2 * pi)) *
              waveHeight;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
