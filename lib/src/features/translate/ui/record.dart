import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/utils/wave.dart';
import 'package:ai_translator/src/shared/widgets/bottom_sheet.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    context.read<RecordingViewModel>().initializeSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      imageBg: sMainBg,
      child: SafeArea(
          child: VerticalPadding(
        child: Consumer<RecordingViewModel>(
          builder: (_, value, child) => Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HorizontalPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppbackButton(
                          onPressed: () {
                            value.resetTranslation();
                            Navigator.pop(context);
                          },
                        ),
                        const SettingsButton()
                      ],
                    ),
                  ),
                  // Text Prompt
                  if (value.translatedTextAndSpeech.isEmpty)
                    Column(
                      children: [
                        VerticalSpacer(
                          space: verticalPadding,
                        ),
                        const HorizontalPadding(child: SwapWidget()),
                        VerticalSpacer(
                          space: 50.h,
                        ),
                        FadingTextWidget(
                          text: value.spokenText,
                          textStyle: context.displayLarge,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 70.h),
                          child: SizedBox(
                            height: 150.h,
                            child: Stack(
                              fit: StackFit.expand,
                              alignment: Alignment.center,
                              children: [
                                if (value.isListening)
                                  Positioned(
                                      top: 0,
                                      child: Text(
                                        'Listening....',
                                        style: context.bodyLarge,
                                      )),
                                const AnimatedWave(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              Positioned(
                bottom: 100.h,
                left: 0,
                right: 0,
                child: RippleEffectButton(
                  isRecording: value.isListening,
                  isTranslating: value.isTranslating,
                  onPressed: () {
                    if (value.isListening) {
                      value.stopListening();
                    } else {
                      value.resetTranslation();
                      value.startListening(
                          targetLanguage: value.translatedLanguage,
                          fromLanguage: value.fromLanguage);
                    }
                  },
                ),
              ),
              if (value.translatedTextAndSpeech.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                      top: 70.h,
                      left: horizontalPadding,
                      right: horizontalPadding),
                  child: Column(
                    children: [
                      const SwapWidget(),
                      Container(
                        margin: EdgeInsets.only(top: 20.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(bigBorderRadius),
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
                                      text: value.translatedTextAndSpeech[0],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: verticalPadding),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppFabButton(
                                        icon: CupertinoIcons.restart,
                                        onPressed: () {
                                          value.resetTranslation();
                                        },
                                      ),
                                      AppFabButton(
                                        icon: CupertinoIcons.play_fill,
                                        onPressed: () async {
                                          await value.playTranslatedText();
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      )),
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
          padding: EdgeInsets.all(5.sp),
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
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingViewModel>(
      builder: (context, value, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainActionButton(
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
    return AppFabButton(
      onPressed: onPressed,
      icon: CupertinoIcons.arrow_right_arrow_left,
    );
  }
}

class FadingTextWidget extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  const FadingTextWidget({super.key, required this.text, this.textStyle});

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
        style: widget.textStyle ??
            TextStyle(
              color: kTabFade1,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class RippleEffectButton extends StatefulWidget {
  const RippleEffectButton(
      {super.key,
      required this.isTranslating,
      required this.isRecording,
      required this.onPressed});
  final bool isTranslating, isRecording;
  final VoidCallback onPressed;

  @override
  State<RippleEffectButton> createState() => _RippleEffectButtonState();
}

class _RippleEffectButtonState extends State<RippleEffectButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: widget.onPressed,
      padding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (widget.isRecording)
            for (int i = 0; i < 3; i++)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  double scale = 1 + (_controller.value * (i + 1) * 0.4);
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 50.h,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor2.withOpacity(
                          (0.5 - _controller.value).clamp(0.0, 1.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
          IconBackgroundWidget(
            height: 50.h,
            width: 50.h,
            hasGradient: true,
            child: !widget.isTranslating
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      sMic,
                      colorFilter: const ColorFilter.mode(
                          kSecondaryFade1, BlendMode.srcIn),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: kBackgroundColor,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
