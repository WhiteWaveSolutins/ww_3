import 'package:ai_translator/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/onboarding/onboarding/content.dart';
import 'package:ai_translator/src/features/onboarding/splash/splash.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/loaders.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      builder: (context, value, child) => AppBackground(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: kAppsize(context).height * 0.7,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: onboardingContents.length,
                      onPageChanged: (value) {
                        _currentIndex = value;
                        setState(() {});
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: kAppsize(context).height * 0.07),
                                  height: kAppsize(context).height * 0.45,
                                  child: Image.asset(
                                    onboardingContents[index].image,
                                    fit: BoxFit.fitWidth,
                                    width: kAppsize(context).width,
                                  ),
                                ),
                                const VerticalSpacer(),
                                HorizontalPadding(
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Column(
                                      children: [
                                        Text(
                                          onboardingContents[index].title,
                                          style: context.headlineLarge.bold,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 50.w),
                                          child: Text(
                                            onboardingContents[index]
                                                .description,
                                            style: context.bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            if (_currentIndex < 1)
                              Positioned(
                                top: verticalPadding,
                                child: const SafeArea(
                                  child: AppLogo(),
                                ),
                              ),
                          ],
                        );
                      }),
                ),
                Expanded(
                  child: VerticalPadding(
                    padding: 25.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HorizontalPadding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppFabButton(
                                opacity: _currentIndex < 3 ? 1 : 0.4,
                                onPressed: !value.isLoading
                                    ? () async {
                                        await showNextContents(value);
                                      }
                                    : null,
                              ),
                              HorizontalPadding(
                                child: TranslatorPrimaryButton(
                                  opacity: value.isLoading ? 0.5 : 1,
                                  title: _currentIndex < 3
                                      ? 'Next'
                                      : 'Try Free & Subscribe',
                                  onPressed: !value.isLoading
                                      ? () async {
                                          await showNextContents(value,
                                              canLogin: true);
                                        }
                                      : null,
                                ),
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
                              itemCount: onboardingContents.length,
                              itemBuilder: (context, index) => BuildDotWidget(
                                index: index,
                                currentIndex: _currentIndex,
                              ),
                            ),
                          ),
                        )),
                        const PrivacyPolicyWidgets(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (value.isLoading) const AppLoader()
          ],
        ),
      ),
    );
  }

  Future<void> showNextContents(AuthenticationViewModel value,
      {bool? canLogin = false}) async {
    if (_currentIndex < 3) {
      _pageController.animateToPage(_currentIndex + 1,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    } else {
      if (canLogin!) {
        await value.login();
        moveToMainScreen();
      }
    }
  }

  void moveToMainScreen() {
    Navigator.pushReplacementNamed(
      context,
      MainScreen.routeName,
    );
  }
}

class BuildDotWidget extends StatelessWidget {
  const BuildDotWidget({
    super.key,
    required this.index,
    required this.currentIndex,
  });
  final int index, currentIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.5.sp),
      child: Container(
        width: currentIndex == index ? 12.w : 7.w,
        decoration: BoxDecoration(
          shape: currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: currentIndex == index ? BorderRadius.circular(4) : null,
          gradient: currentIndex == index ? kPrimaryGradient : null,
          color: currentIndex == index ? null : kPrimaryColor1.withOpacity(0.3),
        ),
      ),
    );
  }
}
