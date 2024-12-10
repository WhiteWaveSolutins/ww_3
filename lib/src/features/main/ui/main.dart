import 'package:ai_translator/src/features/main/ui/history.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/ui/camera.dart';
import 'package:ai_translator/src/features/translate/ui/record.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
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
        trailing: const SettingsButton(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
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
                        onPressed: () {
                          Navigator.restorablePushNamed(
                              context, RecordingScreen.routeName);
                        },
                        icon: sMic,
                      ),
                      MainActionButton(
                        language: "Camera",
                        onPressed: () {
                          Navigator.restorablePushNamed(
                              context, CameraScreen.routeName);
                        },
                        icon: sCamera,
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
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context, HistoryScreen.routeName);
                      },
                      child: Text(
                        'See All',
                        style: context.bodyMedium,
                      ),
                    ),
                  ],
                )),
                if (historyItems.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: kAppsize(context).width * 0.55,
                        child: Column(
                          children: [
                            HistoryWidget(
                              historyItem: historyItems[0],
                            ),
                            HistoryWidget(
                              historyItem: historyItems[1],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: horizontalPadding,
                      ),
                      Expanded(
                        child: HistoryWidget(
                          historyItem: historyItems[2],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (historyItems.isEmpty)
            Positioned(
              bottom: 0,
              child: Center(
                child: SvgPicture.asset(sMain),
              ),
            )
        ],
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
        child: const Icon(CupertinoIcons.settings));
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
    return Container(
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
                Stack(
                  children: [
                    SvgPicture.asset(sUsa),
                    HorizontalPadding(child: SvgPicture.asset(sFrance))
                  ],
                ),
              if (isHistory!) SvgPicture.asset(sUsa),
              Text(historyItem.word),
              if (isHistory!)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalPadding(
                        child: AppDivider(
                      color: kTabFade1.withOpacity(0.3),
                    )),
                    SvgPicture.asset(sUsa),
                    Text(historyItem.translation),
                  ],
                ),
            ],
          ),
        ],
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
    this.hPadding,
    this.onPressed,
    this.iconWidget,
  });

  final String language;
  final String? icon;
  final double? hPadding;
  final VoidCallback? onPressed;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    assert(icon != null || iconWidget != null);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 45.h,
        padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? horizontalPadding,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(bigBorderRadius),
            color: kSecondaryFade1.withOpacity(0.05)),
        child: Row(
          children: [
            iconWidget == null
                ? SvgPicture.asset(
                    icon!,
                  )
                : iconWidget!,
            HorizontalPadding(
              child: Text(
                language,
                style: context.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryItem {
  final List<String> countries;
  final String word;
  final String translation;

  HistoryItem(
      {required this.countries, required this.word, required this.translation});
}
