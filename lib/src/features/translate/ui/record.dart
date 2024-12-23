import 'package:ai_translator/src/features/main/presentation/ui/widgets/widgets.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/features/translate/ui/widgets/widgets.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/wave.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
