import 'package:ai_translator/src/features/main/data/model.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
                  if (historyItem.translations.isNotEmpty)
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
                        Text(historyItem.translations[0]),
                      ],
                    ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AppFabButton(
                icon: CupertinoIcons.play_fill,
                onPressed: () async {
                  await value.playTranslatedText(
                      textAndSound: historyItem.translations);
                },
              ),
            )
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
