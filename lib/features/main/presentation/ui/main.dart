import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/assets.dart';
import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/utils/text_theme.dart';
import '../../../../shared/utils/theme.dart';
import '../../../../shared/widgets/animated_column_and_row.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/drop_down.dart';
import '../../../../shared/widgets/scaffold.dart';
import '../../../../shared/widgets/textfields.dart';
import '../../../settings/ui/settings.dart';
import '../../../translate/logic/viewmodel.dart';
import '../../../translate/ui/image_translate.dart';
import '../../../translate/ui/record.dart';
import '../../../translate/ui/widgets/widgets.dart';
import '../viewmodel/history_viewmodel.dart';
import 'history.dart';
import 'widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const routeName = '/main';

  @override
  State<MainScreen> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<MainScreen> {
  @override
  void initState() {
    context.read<RecordingViewModel>().initializeSpeech();
    context.read<HistoryViewmodel>().getHistoryItem();
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      context.read<RecordingViewModel>().textEditingController.dispose();
      context.read<RecordingViewModel>().disposeValues();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingViewModel>(
      builder: (context, value, child) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AppBackground(
          imageBg: sMainBg,
          child: SafeArea(
            child: HorizontalPadding(
              child: Stack(
                children: [
                  if (context
                      .read<HistoryViewmodel>()
                      .getHistoryItem()
                      .histories
                      .isEmpty)
                    if (!value.isActive)
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          sMain,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeaderText(
                            text: 'Welcome back!',
                          ),
                          SettingsButton(),
                        ],
                      ),
                      _MainBodyWidget(
                        value: value,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MainBodyWidget extends StatelessWidget {
  const _MainBodyWidget({
    required this.value,
  });
  final RecordingViewModel value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: VerticalPadding(
        child: SingleChildScrollView(
          child: TranslatorAnimatedColumn(
            children: [
              Container(
                height: value.isActive
                    ? kAppSize(context).height * 0.4
                    : kAppSize(context).height * 0.2,
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bigBorderRadius),
                  color: kSecondaryFade1.withValues(alpha: .05),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SwapWidget(),
                        const VerticalSpacer(),
                        CupertinoTextField(
                          placeholder: 'Enter the Text...',
                          controller: value.textEditingController,
                          placeholderStyle: context.bodyLarge.copyWith(
                            color: kTextColor.withValues(alpha: .7),
                          ),
                          maxLines: value.isActive ? 3 : 1,
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            value.translateText(
                                isSpeaking: false, canSave: true);
                          },
                          onChanged: (s) {
                            if (s.length > 2) {
                              value.isActive = true;
                              value.onTextChanged(s, (finalText) {
                                value.translateText(
                                    isSpeaking: false, canSave: s.length > 60);
                              });
                            }
                          },
                          decoration: const BoxDecoration(border: Border()),
                        ),
                        if (value.isActive)
                          Stack(
                            children: [
                              VerticalPadding(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AppDivider(
                                      color: kTabFade1,
                                    ),
                                    if (value
                                        .translatedTextAndSpeech.isNotEmpty)
                                      VerticalPadding(
                                          child: FadingTextWidget(
                                              text: value
                                                  .translatedTextAndSpeech[0]))
                                  ],
                                ),
                              ),
                              if (value.isTranslating)
                                const Center(child: CircularProgressIndicator())
                            ],
                          )
                      ],
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: verticalPadding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                          value.translatedTextAndSpeech);
                                },
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              VerticalPadding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainActionButton(
                      height: 50,
                      width: 150,
                      language: "Voice",
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context, RecordingScreen.routeName);
                        value.resetTranslation();
                      },
                      iconWidget: IconBackgroundWidget(svgIcon: sMic),
                    ),
                    MainActionButton(
                      height: 50,
                      width: 150,
                      language: "Camera",
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context, TextRecognizerView.routeName);
                        value.resetTranslation();
                      },
                      iconWidget: IconBackgroundWidget(svgIcon: sCameraSvg),
                    ),
                  ],
                ),
              ),
              VerticalPadding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeaderText(
                      text: 'History',
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        value.resetTranslation();
                        Navigator.restorablePushNamed(
                            context, HistoryScreen.routeName);
                      },
                      child: Opacity(
                        opacity: 0.8,
                        child: Text(
                          'See all',
                          style: context.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (context
                  .read<HistoryViewmodel>()
                  .getHistoryItem()
                  .histories
                  .isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: kAppSize(context).width * 0.5,
                      child: Column(
                        children: [
                          HistoryWidget(
                            historyItem: (context
                                .read<HistoryViewmodel>()
                                .getHistoryItem()
                                .histories)[0],
                          ),
                          if (context
                                  .read<HistoryViewmodel>()
                                  .getHistoryItem()
                                  .histories
                                  .length >
                              1)
                            HistoryWidget(
                              historyItem: (context
                                  .read<HistoryViewmodel>()
                                  .getHistoryItem()
                                  .histories)[1],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: horizontalPadding),
                    if (context
                            .read<HistoryViewmodel>()
                            .getHistoryItem()
                            .histories
                            .length >
                        2)
                      Expanded(
                        child: HistoryWidget(
                          historyItem: context
                              .read<HistoryViewmodel>()
                              .getHistoryItem()
                              .histories[2],
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
