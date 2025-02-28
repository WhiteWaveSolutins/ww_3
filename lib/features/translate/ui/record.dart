import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../shared/utils/assets.dart';
import '../../../shared/utils/size_utils.dart';
import '../../../shared/utils/text_theme.dart';
import '../../../shared/utils/theme.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/drop_down.dart';
import '../../../shared/widgets/scaffold.dart';
import '../../../shared/widgets/textfields.dart';
import '../../../shared/widgets/wave.dart';
import '../../main/presentation/ui/widgets/widgets.dart';
import '../../settings/ui/settings.dart';
import '../logic/viewmodel.dart';
import 'widgets/widgets.dart';

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
                          AppBackButton(
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
                          const VerticalSpacer(space: 50),
                          HorizontalPadding(
                            child: FadingTextWidget(
                              text: value.spokenText,
                              textStyle: context.displayLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: SizedBox(
                              height: 150,
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
                  bottom: 100,
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
                        top: 70,
                        left: horizontalPadding,
                        right: horizontalPadding),
                    child: Column(
                      children: [
                        const SwapWidget(),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: verticalPadding),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(bigBorderRadius),
                              color: kSecondaryFade1.withValues(alpha: .05)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      VerticalPadding(
                                          child: AppDivider(
                                        color: kTabFade1.withValues(alpha: .3),
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
                                            await value.playTranslatedText(
                                              textAndSound:
                                                  value.translatedTextAndSpeech,
                                            );
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
        ),
      ),
    );
  }
}
