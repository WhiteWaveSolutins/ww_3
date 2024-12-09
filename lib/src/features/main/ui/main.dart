import 'dart:math';

import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
      appBar: CupertinoNavigationBar(
        leading: Text(
          'Welcome Back!',
          style: context.displayLarge,
        ),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.restorablePushNamed(
                  context, TranslatorSettingsScreen.routeName);
            },
            child: const Icon(CupertinoIcons.settings)),
      ),
      body: HorizontalPadding(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: kAppsize(context).height * 0.3,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(bigBorderRadius),
                      color: kSecondaryFade1.withOpacity(0.05)),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MainActionButton(language: "English", icon: sUsa),
                              SvgPicture.asset(sSwap),
                              MainActionButton(
                                  language: "French", icon: sFrance),
                            ],
                          ),
                          CupertinoTextField(
                            placeholder: 'Enter the Text...',
                            placeholderStyle: context.bodyLarge,
                            decoration: const BoxDecoration(border: Border()),
                          ),
                        ],
                      ),
                      Positioned(
                          bottom: 0, right: 0, child: SvgPicture.asset(sPlay))
                    ],
                  ),
                ),
                VerticalPadding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainActionButton(
                        language: "Voice",
                        icon: sMic,
                        vPadding: 2.h,
                      ),
                      MainActionButton(
                        language: "Camera",
                        icon: sCamera,
                        vPadding: 2.h,
                      ),
                    ],
                  ),
                ),
                VerticalPadding(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'History',
                      style: context.displayLarge,
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: Text(
                        'See All',
                        style: context.bodyMedium,
                      ),
                    ),
                  ],
                )),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Center(
                child: SvgPicture.asset(sMain),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildDotWidget extends StatelessWidget {
  const BuildDotWidget(
      {super.key,
      required this.index,
      required this.currentIndex,
      required this.height,
      required this.width});
  final int index, currentIndex;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: currentIndex == index ? (width * 1.6) : width,
      margin: EdgeInsets.only(
        right: smallTextSize,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              currentIndex == index ? kPrimaryGradient : kTabFadedGradient,
          boxShadow: [
            BoxShadow(
                color: currentIndex == index ? kTabFade1 : kPrimaryColor1,
                blurRadius: 2,
                offset: const Offset(-0.2, 0.2),
                spreadRadius: 0.2)
          ]),
    );
  }
}

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
    return Scaffold(
      backgroundColor: const Color(0xFF0F1E29),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1E29),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
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
                const Icon(Icons.swap_horiz,
                    color: Colors.greenAccent, size: 30),
                MainActionButton(
                  language: "French",
                  icon: sUsa,
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
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Tap the button below to start recording.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
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
                  width: 100 + (_animationController.value * 20),
                  height: 100 + (_animationController.value * 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent.withOpacity(0.5),
                  ),
                  child: child,
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
                child: const Icon(Icons.mic, size: 50, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class MainActionButton extends StatelessWidget {
  const MainActionButton({
    super.key,
    required this.language,
    required this.icon,
    this.vPadding,
    this.hPadding,
  });

  final String language;
  final String icon;
  final double? vPadding, hPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? horizontalPadding,
          vertical: vPadding ?? verticalPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(bigBorderRadius),
          color: kSecondaryFade1.withOpacity(0.05)),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
          ),
          HorizontalPadding(
            child: Text(
              language,
              style: context.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wavePaint = Paint()
      ..color = Colors.purpleAccent.withOpacity(0.7)
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
