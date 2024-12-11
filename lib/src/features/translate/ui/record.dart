import 'dart:math';

import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/bottom_sheet.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class RecordingScreen extends StatefulWidget {
  static const routeName = '/record';
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
    context.read<RecordingViewModel>().initializeSpeech();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
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
      appBar: const CupertinoNavigationBar(
          leading: AppbackButton(), trailing: SettingsButton()),
      body: Consumer<RecordingViewModel>(
        builder: (_, value, child) => HorizontalPadding(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Language Selection

                  // Text Prompt
                  if (value.translatedText.isEmpty)
                    Column(
                      children: [
                        const SwapWidget(),
                        FadingTextWidget(text: value.spokenText),
                        // Wave Animation
                        Padding(
                          padding: EdgeInsets.only(top: 100.h),
                          child: SizedBox(
                            height: 150.h,
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                if (value.isListening)
                                  const Positioned(
                                      bottom: 0, child: Text('Listening....')),
                                SvgPicture.asset(
                                  sRecordBackground,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 50.h),
                                  child: AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      return Opacity(
                                        opacity: 0.1,
                                        child: CustomPaint(
                                            painter: WavePainter(
                                                _animationController.value),
                                            child: Container()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  // Pulsing Microphone
                ],
              ),
              if (value.translatedText.isEmpty)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                          margin: EdgeInsets.only(
                              bottom: kAppsize(context).width * 0.4),
                          width: 20.h + (_animationController.value * 20),
                          height: 20.h + (_animationController.value * 20),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor1.withOpacity(0.1)),
                          child: Center(
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (value.isListening) {
                                  value.stopListening();
                                } else {
                                  value.startListening(
                                      targetLanguage: value.translatedLanguage,
                                      fromLanguage: value.fromLanguage);
                                }
                              },
                              child: value.isTranslating
                                  ? const CircularProgressIndicator()
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          bigBorderRadius),
                                      child: SvgPicture.asset(
                                        sMicBig,
                                        colorFilter: ColorFilter.mode(
                                            value.isListening
                                                ? kPrimaryColor1
                                                : kTabFade1,
                                            BlendMode.color),
                                      ),
                                    ),
                            ),
                          ));
                    },
                  ),
                ),
              if (value.translatedText.isNotEmpty)
                Column(
                  children: [
                    const SwapWidget(),
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(bigBorderRadius),
                          color: kSecondaryFade1.withOpacity(0.05)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadingTextWidget(
                                text: value.spokenText,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerticalPadding(
                                      child: AppDivider(
                                    color: kTabFade1.withOpacity(0.3),
                                  )),
                                  FadingTextWidget(
                                    text: value.translatedText,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: verticalPadding),
                                child: SizedBox(
                                  height: 40.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ActionButton(
                                        icon: CupertinoIcons.restart,
                                        onPressed: () {
                                          value.resetTranslation();
                                        },
                                      ),
                                      ActionButton(
                                        icon: CupertinoIcons.play_fill,
                                        onPressed: () async {
                                          await value.playTranslatedText();
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });
  final VoidCallback? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
          padding: EdgeInsets.all(5.fSize),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, gradient: kPrimaryGradient),
          child: Icon(
            icon,
            color: kBackgroundColor,
          )),
    );
  }
}

class SwapWidget extends StatelessWidget {
  const SwapWidget({
    super.key,
    this.hPadding,
    this.vPadding,
  });
  final double? hPadding, vPadding;

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingViewModel>(
      builder: (context, value, child) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: hPadding ?? 18.w, vertical: vPadding ?? 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MainActionButton(
              hPadding: value.inputLang['name']!.length > 8
                  ? smallHorizontalPadding
                  : horizontalPadding,
              language: value.inputLang['name']!,
              icon: value.inputLang['flag'],
              onPressed: () {
                showLanguagePicker(
                  context,
                  value,
                  isInput: true,
                );
              },
            ),
            SwapIcon(
              onPressed: () {
                final outputLang = value.inputLang;
                final inptLang = value.outputLang;
                value.setInputLanguage(inptLang);
                value.setOutputLanguage(outputLang);
                value.resetTranslation();
              },
            ),
            MainActionButton(
              language: value.outputLang['name']!,
              icon: value.outputLang['flag'],
              onPressed: () {
                showLanguagePicker(context, value);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showLanguagePicker(
      BuildContext context, RecordingViewModel value,
      {bool? isInput = false}) {
    return showAppBottomSheet(context,
        isDismissible: true,
        child: Column(
          children: value.languages.map((language) {
            return CupertinoButton(
              onPressed: () {
                if (isInput!) {
                  value.setInputLanguage(language);
                } else {
                  value.setOutputLanguage(language);
                }

                Navigator.pop(context); // Close the bottom sheet
              },
              child: Container(
                padding: EdgeInsets.all(verticalPadding),
                decoration: BoxDecoration(
                    color: kTabFade1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(bigBorderRadius)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(language['flag']!),
                        const HorizontalSpacer(),
                        Text(language['name']!),
                      ],
                    ),
                    CupertinoButton(
                      onPressed: () {
                        if (isInput!) {
                          value.setInputLanguage(language);
                        } else {
                          value.setOutputLanguage(language);
                        }
                      },
                      padding: EdgeInsets.zero,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: kTabFade2,
                            ),
                            shape: BoxShape.circle),
                        child: Container(
                          height: 25.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                              gradient:
                                  (value.fromLanguage == language['code']! ||
                                          value.translatedLanguage ==
                                              language['code']!)
                                      ? kPrimaryGradient
                                      : const LinearGradient(colors: [
                                          CupertinoColors.transparent,
                                          CupertinoColors.transparent
                                        ]),
                              shape: BoxShape.circle),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }
}

class SwapIcon extends StatelessWidget {
  const SwapIcon({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onPressed, child: SvgPicture.asset(sSwap));
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

class FadingTextWidget extends StatefulWidget {
  final String text;

  const FadingTextWidget({super.key, required this.text});

  @override
  State<FadingTextWidget> createState() => _FadingTextWidgetState();
}

class _FadingTextWidgetState extends State<FadingTextWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust fade duration
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);

    // Start fading
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation!,
      child: Text(
        widget.text,
        style: TextStyle(
          color: kTabFade1,
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({super.key});

  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // Continuous animation
    _waveAnimation = Tween<double>(begin: 0, end: 100).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _waveAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _waveAnimation.value), // Vertical wave motion
                child: SvgPicture.asset(
                  sRecordBackground, // Add your wave.svg file in assets
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
