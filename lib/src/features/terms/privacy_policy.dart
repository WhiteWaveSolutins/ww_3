import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return AppBackground(
      imageBg: sMainBg,
      child: SafeArea(
        child: VerticalPadding(
          child: Column(
            children: [
              HorizontalPadding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const AppbackButton(),
                    HorizontalSpacer(
                      space: 50.w,
                    ),
                    Container(
                      height: 40.h,
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.sp),
                          gradient: kPrimaryGradient),
                      child: Container(
                        width: kAppsize(context).width * 0.4,
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.sp),
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
                                  width: kAppsize(context).width * 0.2,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    gradient: kPrimaryGradient,
                                    borderRadius:
                                        BorderRadius.circular(bigBorderRadius),
                                  ),
                                ),
                              ),
                              HorizontalPadding(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTab(
                                      text: "Privacy",
                                      isSelected: selectedIndex == 0,
                                      onTap: () {
                                        pageController.animateToPage(0,
                                            duration: const Duration(
                                                milliseconds: 300),
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
                                            duration: const Duration(
                                                milliseconds: 300),
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
                  ],
                ),
              ),
              Expanded(
                child: HorizontalPadding(
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
                            const Opacity(
                                opacity: 0.7, child: Text(privacyPolicyText)),
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
                            const Opacity(
                                opacity: 0.7, child: Text(privacyPolicyText)),
                          ]),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
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
