import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
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

  final historyItems = [
    HistoryItem(
        countries: ['usa', 'france'],
        word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
        translation: 'a very long translated text'),
    HistoryItem(
        countries: ['usa', 'france'],
        word: 'a very long text',
        translation:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...'),
    HistoryItem(
        countries: ['usa', 'france'],
        word:
            'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, Lorem ipsum dolor sit amet, consectetuer adipiscing elit..., Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
        translation: 'a very long translated text'),
    HistoryItem(
        countries: ['usa', 'france'],
        word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
        translation: 'a very long translated text'),
    HistoryItem(
        countries: ['usa', 'france'],
        word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
        translation: 'a very long translated text'),
    HistoryItem(
        countries: ['usa', 'france'],
        word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
        translation: 'a very long translated text'),
  ];
  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
      appBar: CupertinoNavigationBar(
        leading: Text(
          'Welcome Back!',
          style: context.displayLarge,
        ),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.restorablePushNamed(
                  context, TranslatorSettingsScreen.routeName);
            },
            child: const Icon(CupertinoIcons.settings)),
      ),
      body: HorizontalPadding(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: kAppsize(context).height * 0.3,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                                MainActionButton(
                                    language: "English", icon: sUsa),
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
                          icon: sMic,
                          vPadding: 2.h,
                        ),
                        MainActionButton(
                          language: "Camera",
                          icon: sCamera,
                          vPadding: 2.h,
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
                        onPressed: () {},
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
      ),
    );
  }
}

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.historyItem,
  });
  final HistoryItem historyItem;
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
            child: SvgPicture.asset(sMore),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(sUsa),
                  HorizontalPadding(child: SvgPicture.asset(sFrance))
                ],
              ),
              Text(historyItem.word)
            ],
          ),
        ],
      ),
    );
  }
}

class BuildDotWidget extends StatelessWidget {
  const BuildDotWidget(
      {super.key,
      required this.index,
      required this.currentIndex,
      required this.height,
      required this.width});
  final int index, currentIndex;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: currentIndex == index ? (width * 1.6) : width,
      margin: EdgeInsets.only(
        right: smallTextSize,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              currentIndex == index ? kPrimaryGradient : kTabFadedGradient,
          boxShadow: [
            BoxShadow(
                color: currentIndex == index ? kTabFade1 : kPrimaryColor1,
                blurRadius: 2,
                offset: const Offset(-0.2, 0.2),
                spreadRadius: 0.2)
          ]),
    );
  }
}

class MainActionButton extends StatelessWidget {
  const MainActionButton({
    super.key,
    required this.language,
    required this.icon,
    this.vPadding,
    this.hPadding,
  });

  final String language;
  final String icon;
  final double? vPadding, hPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: hPadding ?? horizontalPadding,
          vertical: vPadding ?? verticalPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(bigBorderRadius),
          color: kSecondaryFade1.withOpacity(0.05)),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
          ),
          HorizontalPadding(
            child: Text(
              language,
              style: context.bodySmall,
            ),
          ),
        ],
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
