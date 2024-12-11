import 'package:ai_translator/src/features/authentication/logic/authentication_viewmodel.dart';
import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/onboarding/onboarding/content.dart';
import 'package:ai_translator/src/features/onboarding/splash/splash.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, value, child) => TranslatorScaffold(
        isLoading: value.isLoading,
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                height: kAppsize(context).height * 0.7,
                width: double.infinity,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingContents.length - 1,
                    onPageChanged: (value) {
                      _currentIndex = value;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: index == 1
                                    ? kAppsize(context).height * 0.05
                                    : index == 2
                                        ? kAppsize(context).height * 0.1
                                        : 0),
                            child: index == 0
                                ? Align(
                                    alignment: Alignment.topCenter,
                                    child: SvgPicture.asset(
                                      onboardingContents[index].image.first,
                                    ),
                                  )
                                : index == 1
                                    ? SizedBox(
                                        height: kAppsize(context).height * 0.4,
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 70.h, left: 80.h),
                                              child: Opacity(
                                                opacity: 0.5,
                                                child: SvgPicture.asset(
                                                  onboardingContents[index]
                                                      .image[2],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 100.h),
                                                  child: Stack(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 30.h,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          onboardingContents[
                                                                  index]
                                                              .image[0],
                                                        ),
                                                      ),
                                                      SvgPicture.asset(
                                                        onboardingContents[
                                                                index]
                                                            .image[1],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 50.h),
                                                  child: Stack(
                                                    children: [
                                                      SvgPicture.asset(
                                                        onboardingContents[
                                                                index]
                                                            .image[3],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              bottom: 70.h,
                                              left: 60.h,
                                              child: Stack(
                                                children: [
                                                  SvgPicture.asset(
                                                    onboardingContents[index]
                                                        .image[4],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.topCenter,
                                        child: SvgPicture.asset(
                                          onboardingContents[index].image.first,
                                        ),
                                      ),
                          ),
                          Positioned(
                            top: kAppsize(context).height * 0.5,
                            width: kAppsize(context).width,
                            child: Column(
                              children: [
                                Text(
                                  onboardingContents[index].title,
                                  style: context.headlineLarge.bold,
                                ),
                                VerticalPadding(
                                  child: Text(
                                    onboardingContents[index].description,
                                    style: context.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
              ),
              const AppLogo(),
              Positioned(
                bottom: verticalPadding,
                child: SizedBox(
                  width: kAppsize(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerticalPadding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppFabButton(
                              onPressed: () async {
                                await value.login();
                                moveToMainScreen();
                              },
                            ),
                            TranslatorPrimaryButton(
                              title: 'Next',
                              onPressed: () async {
                                if (_currentIndex < 2) {
                                  _pageController.animateToPage(
                                      _currentIndex + 1,
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.linear);
                                } else {
                                  await value.login();
                                  moveToMainScreen();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      VerticalPadding(
                          child: SizedBox(
                        height: 10.h,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: kAppsize(context).width * 0.45),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: onboardingContents.length - 1,
                            itemBuilder: (context, index) => BuildDotWidget(
                              index: index,
                              currentIndex: _currentIndex,
                              height: 3.h,
                              width: 5.h,
                            ),
                          ),
                        ),
                      )),
                      HorizontalPadding(
                        padding: kAppsize(context).width * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CupertinoButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                child: Text(
                                  'Terms of Use',
                                  style: context.bodySmall,
                                )),
                            CupertinoButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                child: Text(
                                  'Privacy Policy',
                                  style: context.bodySmall,
                                )),
                            CupertinoButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                child: Text(
                                  'Restore',
                                  style: context.bodySmall,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveToMainScreen() {
    Navigator.pushReplacementNamed(
      context,
      MainScreen.routeName,
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
