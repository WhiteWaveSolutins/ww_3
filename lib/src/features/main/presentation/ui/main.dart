import 'package:ai_translator/src/features/main/presentation/ui/history.dart';
import 'package:ai_translator/src/features/main/presentation/ui/widgets/widgets.dart';
import 'package:ai_translator/src/features/main/presentation/viewmodel/history_viewmodel.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/features/translate/ui/image_translate.dart';
import 'package:ai_translator/src/features/translate/ui/record.dart';
import 'package:ai_translator/src/features/translate/ui/widgets/widgets.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/animated_column_and_row.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
                      .historyItemList
                      .histories
                      .isEmpty)
                    if (!value.isActive)
                      Positioned(
                        bottom: 20.h,
                        left: 0,
                        right: 0,
                        child: SvgPicture.asset(
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
                    ? kAppsize(context).height * 0.35
                    : kAppsize(context).height * 0.2,
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(bigBorderRadius),
                    color: kSecondaryFade1.withOpacity(0.05)),
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
                          placeholderStyle: context.bodyLarge
                              .copyWith(color: kTextColor.withOpacity(0.7)),
                          maxLines: value.isActive ? 2 : 1,
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
                                    isSpeaking: false, canSave: s.length > 40);
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
                          padding: EdgeInsets.only(top: verticalPadding),
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
                                  await value.playTranslatedText();
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
                      height: 50.h,
                      width: 150.w,
                      language: "Voice",
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context, RecordingScreen.routeName);
                        value.resetTranslation();
                      },
                      iconWidget: IconBackgroundWidget(svgIcon: sMic),
                    ),
                    MainActionButton(
                      height: 50.h,
                      width: 150.w,
                      language: "Camera",
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context, TextRecognizerView.routeName);
                        value.resetTranslation();
                      },
                      iconWidget: const IconBackgroundWidget(
                        icon: CupertinoIcons.camera_fill,
                        iconColor: kPrimaryColor1,
                      ),
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
                      width: kAppsize(context).width * 0.55,
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
                    SizedBox(
                      width: horizontalPadding,
                    ),
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
