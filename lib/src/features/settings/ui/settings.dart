import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class TranslatorSettingsScreen extends StatefulWidget {
  const TranslatorSettingsScreen({super.key});

  static const routeName = '/trans_settings';

  @override
  State<TranslatorSettingsScreen> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<TranslatorSettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
      appBar: CupertinoNavigationBar(
        leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: SvgPicture.asset(sBackButton),
            onPressed: () {
              Navigator.pop(context);
            }),
        middle: Text(
          'Settings',
          style: context.displayLarge,
        ),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Icon(CupertinoIcons.settings)),
      ),
      body: VerticalPadding(
        child: HorizontalPadding(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: kAppsize(context).height * 0.1,
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(bigBorderRadius),
                        color: kSecondaryFade1.withOpacity(0.05)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Get free trial for a week'),
                        CupertinoButton(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kTextColorDarkMode,
                                  borderRadius:
                                      BorderRadius.circular(15.fSize)),
                              // child: Text(
                              //   'Upgrade',
                              //   style: context.bodyMedium.primary,
                              // ),
                            ),
                            onPressed: () {})
                      ],
                    ),
                  ),
                  const VerticalPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // MainActionButton(
                        //   language: "Voice",
                        //   icon: sMic,
                        //   vPadding: 2.h,
                        // ),
                        // MainActionButton(
                        //   language: "Camera",
                        //   icon: sCamera,
                        //   vPadding: 2.h,
                        // ),
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
                ],
              ),
              Positioned(
                bottom: 0,
                child: Center(
                  child: SvgPicture.asset(sMain),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
