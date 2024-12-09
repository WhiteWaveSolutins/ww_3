import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  static const routeName = '/privacy_policy';

  @override
  State<PrivacyPolicyScreen> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<PrivacyPolicyScreen> {
  int selectedIndex = 0;
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  bool isSwitched = false;

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
          middle: Container(
            padding: EdgeInsets.all(1.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(bigBorderRadius),
                gradient: kPrimaryGradient),
            child: Container(
              width: kAppsize(context).width * 0.4,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(bigBorderRadius),
                  color: kBackgroundColor),
              child: Center(
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: selectedIndex == 0
                          ? 0
                          : kAppsize(context).width * 0.18,
                      child: Container(
                        width: kAppsize(context).width *
                            0.2, // Adjust to fit the tab size
                        height: 35.h, // Match the height of tabs
                        decoration: BoxDecoration(
                          gradient: kPrimaryGradient,
                          borderRadius: BorderRadius.circular(bigBorderRadius),
                        ),
                      ),
                    ),
                    HorizontalPadding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTab(
                            text: "Privacy",
                            isSelected: selectedIndex == 0,
                            onTap: () {
                              pageController.animateToPage(0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                              setState(() {
                                selectedIndex = 0;
                              });
                            },
                          ),
                          // Terms Tab
                          CustomTab(
                            text: "Terms",
                            isSelected: selectedIndex == 1,
                            onTap: () {
                              pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear);
                              setState(() {
                                selectedIndex = 1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: HorizontalPadding(
            child: PageView(
          controller: pageController,
          onPageChanged: (s) {
            selectedIndex = s;
            setState(() {});
          },
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: verticalPadding),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerticalPadding(
                      child: RichText(
                        text: TextSpan(
                            text: 'Privacy ',
                            style: context.headlineLarge.copyWith(
                                color: kPrimaryColor1,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(
                                  text: 'Policy',
                                  style: context.headlineLarge
                                      .copyWith(color: kPrimaryColor2))
                            ]),
                      ),
                    ),
                    const Text(privacyPolicyText),
                  ]),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: verticalPadding),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VerticalPadding(
                      child: RichText(
                        text: TextSpan(
                            text: 'Terms O',
                            style: context.headlineLarge.copyWith(
                                color: kPrimaryColor1,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(
                                  text: 'f Use',
                                  style: context.headlineLarge
                                      .copyWith(color: kPrimaryColor2))
                            ]),
                      ),
                    ),
                    const Text(privacyPolicyText),
                  ]),
            ),
          ],
        )));
  }
}

class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? kTextColorDarkMode : kPrimaryColor1,
        ),
      ),
    );
  }
}
