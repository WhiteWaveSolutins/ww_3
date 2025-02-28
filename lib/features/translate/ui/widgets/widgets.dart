import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/assets.dart';
import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/utils/theme.dart';
import '../../../../shared/widgets/bottom_sheet.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/textfields.dart';
import '../../../main/presentation/ui/widgets/widgets.dart';
import '../../logic/viewmodel.dart';

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
          padding: const EdgeInsets.all(5),
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
    return showAppBottomSheet(
      context,
      isDismissible: true,
      child: Padding(
        padding: EdgeInsets.only(top: bigPadding),
        child: Column(
          children: value.languages.map(
            (language) {
              return CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (isInput!) {
                    value.setInputLanguage(language);
                  } else {
                    value.setOutputLanguage(language);
                  }
                  value.resetTranslation();
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Container(
                  padding: EdgeInsets.all(verticalPadding),
                  margin: EdgeInsets.only(bottom: verticalPadding),
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
                          value.resetTranslation();
                          Navigator.pop(context); // Close the bottom sheet
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
                            height: 25,
                            width: 25,
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
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
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
                overflow: TextOverflow.ellipsis),
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
                      width: 50,
                      height: 50,
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
            height: 50,
            width: 50,
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
