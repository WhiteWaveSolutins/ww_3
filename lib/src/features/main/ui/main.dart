import 'package:ai_translator/src/features/main/logic/history_viewmodel.dart';
import 'package:ai_translator/src/features/main/logic/model.dart';
import 'package:ai_translator/src/features/main/ui/history.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/features/translate/ui/cam.dart';
import 'package:ai_translator/src/features/translate/ui/record.dart';
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
                      Expanded(
                        child: VerticalPadding(
                          child: SingleChildScrollView(
                            child: TranslatorAnimatedColumn(
                              children: [
                                Container(
                                  height: value.isActive
                                      ? kAppsize(context).height * 0.35
                                      : kAppsize(context).height * 0.2,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horizontalPadding,
                                      vertical: verticalPadding),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          bigBorderRadius),
                                      color: kSecondaryFade1.withOpacity(0.05)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SwapWidget(),
                                          const VerticalSpacer(),
                                          CupertinoTextField(
                                            placeholder: 'Enter the Text...',
                                            controller:
                                                value.textEditingController,
                                            placeholderStyle: context.bodyLarge
                                                .copyWith(
                                                    color: kTextColor
                                                        .withOpacity(0.7)),
                                            maxLines: value.isActive ? 2 : 1,
                                            onEditingComplete: () {
                                              FocusScope.of(context).unfocus();
                                              value.translateText(
                                                  isSpeaking: false,
                                                  canSave: true);
                                            },
                                            onChanged: (s) {
                                              if (s.length > 2) {
                                                value.isActive = true;
                                                value.onTextChanged(s,
                                                    (finalText) {
                                                  value.translateText(
                                                      isSpeaking: false,
                                                      canSave: s.length > 40);
                                                });
                                              }
                                            },
                                            decoration: const BoxDecoration(
                                                border: Border()),
                                          ),
                                          if (value.isActive)
                                            Stack(
                                              children: [
                                                VerticalPadding(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const AppDivider(
                                                        color: kTabFade1,
                                                      ),
                                                      if (value
                                                          .translatedTextAndSpeech
                                                          .isNotEmpty)
                                                        VerticalPadding(
                                                            child: FadingTextWidget(
                                                                text: value
                                                                    .translatedTextAndSpeech[0]))
                                                    ],
                                                  ),
                                                ),
                                                if (value.isTranslating)
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                              ],
                                            )
                                        ],
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: verticalPadding),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                                  icon:
                                                      CupertinoIcons.play_fill,
                                                  onPressed: () async {
                                                    await value
                                                        .playTranslatedText();
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MainActionButton(
                                        height: 50.h,
                                        width: 150.w,
                                        language: "Voice",
                                        onPressed: () {
                                          Navigator.restorablePushNamed(context,
                                              RecordingScreen.routeName);
                                          value.resetTranslation();
                                        },
                                        iconWidget:
                                            IconBackgroundWidget(svgIcon: sMic),
                                      ),
                                      MainActionButton(
                                        height: 50.h,
                                        width: 150.w,
                                        language: "Camera",
                                        onPressed: () {
                                          Navigator.restorablePushNamed(context,
                                              TextRecognizerView.routeName);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                )),
                                if (context
                                    .read<HistoryViewmodel>()
                                    .historyItemList
                                    .histories
                                    .isNotEmpty)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: kAppsize(context).width * 0.55,
                                        child: Column(
                                          children: [
                                            HistoryWidget(
                                              historyItem: context
                                                  .read<HistoryViewmodel>()
                                                  .historyItemList
                                                  .histories[0],
                                            ),
                                            if (context
                                                    .read<HistoryViewmodel>()
                                                    .historyItemList
                                                    .histories
                                                    .length >
                                                1)
                                              HistoryWidget(
                                                historyItem: context
                                                    .read<HistoryViewmodel>()
                                                    .historyItemList
                                                    .histories[1],
                                              ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: horizontalPadding,
                                      ),
                                      if (context
                                              .read<HistoryViewmodel>()
                                              .historyItemList
                                              .histories
                                              .length >
                                          2)
                                        Expanded(
                                          child: HistoryWidget(
                                            historyItem: context
                                                .read<HistoryViewmodel>()
                                                .historyItemList
                                                .histories[2],
                                          ),
                                        ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
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

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          Navigator.restorablePushNamed(
              context, TranslatorSettingsScreen.routeName);
        },
        child: IconBackgroundWidget(
          svgIcon: sSettings,
        ));
  }
}

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.historyItem,
    this.onOptionPressed,
    this.isHistory = false,
  });
  final HistoryItem historyItem;
  final void Function()? onOptionPressed;
  final bool? isHistory;
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingViewModel>(
      builder: (context, value, child) => Container(
        margin: EdgeInsets.only(bottom: verticalPadding),
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(bigBorderRadius),
            color: kSecondaryFade1.withOpacity(0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 20.h,
                child: CupertinoButton(
                  onPressed: () {
                    showMenu(context);
                  },
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(sMore),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isHistory!)
                  Row(
                    children: [
                      Text(
                        value.inputLang['flag']!,
                        style: context.displayLarge,
                      ),
                      HorizontalPadding(
                        child: Text(
                          value.outputLang['flag']!,
                          style: context.displayLarge,
                        ),
                      )
                    ],
                  ),
                const VerticalSpacer(),
                if (isHistory!)
                  Text(
                    value.inputLang['flag']!,
                    style: context.displayLarge,
                  ),
                const VerticalSpacer(),
                Text(historyItem.word),
                if (isHistory!)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalPadding(
                          child: AppDivider(
                        color: kTabFade1.withOpacity(0.3),
                      )),
                      Text(
                        value.outputLang['flag']!,
                        style: context.displayLarge,
                      ),
                      const VerticalSpacer(),
                      Text(historyItem.translation),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showMenu(BuildContext context) {
    CupertinoContextMenu(
      enableHapticFeedback: true,
      actions: <Widget>[
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
            // Perform "Open" action
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Open'),
              Icon(CupertinoIcons.pencil),
            ],
          ),
        ),
        CupertinoContextMenuAction(
          onPressed: () {
            Navigator.pop(context);
            // Perform "Copy" action
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Copy'),
              Icon(CupertinoIcons.doc_on_clipboard),
            ],
          ),
        ),
        CupertinoContextMenuAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
            // Perform "Delete" action
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delete'),
              Icon(CupertinoIcons.trash, color: CupertinoColors.destructiveRed),
            ],
          ),
        ),
      ],
      child: Container(
        width: 100,
        height: 100,
        color: CupertinoColors.activeBlue,
        alignment: Alignment.center,
        child: const Text(
          'Hold Me',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
    );
  }

  // void _showCupertinoActionSheet(BuildContext context) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return CupertinoActionSheet(
  //         title: const Text('Select an Option'),
  //         message: const Text('Choose an action to perform'),
  //         actions: <CupertinoActionSheetAction>[
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               // Perform "Open" action
  //             },
  //             child: const Text('Open'),
  //           ),
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               // Perform "Copy" action
  //             },
  //             child: const Text('Copy'),
  //           ),
  //           CupertinoActionSheetAction(
  //             isDestructiveAction: true,
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Delete'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

class MainActionButton extends StatelessWidget {
  const MainActionButton({
    super.key,
    required this.language,
    this.icon,
    this.height,
    this.width,
    this.onPressed,
    this.iconWidget,
  });

  final String language;
  final String? icon;
  final double? height, width;
  final VoidCallback? onPressed;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    assert(icon != null || iconWidget != null);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: height ?? 40.h,
        width: width ?? 120.w,
        padding: EdgeInsets.only(
          left: horizontalPadding,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.sp),
            color: kSecondaryFade1.withOpacity(0.15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconWidget == null ? Text(icon!) : iconWidget!,
            HorizontalSpacer(
              space: smallHorizontalPadding,
            ),
            Text(
              language,
              style: context.bodySmall.bold,
            ),
          ],
        ),
      ),
    );
  }
}
