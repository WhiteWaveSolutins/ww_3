import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/helpers/url_helper.dart';
import '../../../shared/utils/size_utils.dart';
import '../../../shared/utils/text_theme.dart';
import '../../../shared/utils/theme.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/loaders.dart';
import '../../../shared/widgets/scaffold.dart';
import '../../../shared/widgets/textfields.dart';
import '../../authentication/presentation/viewmodel/authentication_viewmodel.dart';
import '../../main/presentation/ui/main.dart';
import '../../subscription/cubit/subscription_cubit.dart';
import '../../subscription/presentation/onboarding_paywall/bloc/onboarding_paywall_bloc.dart';
import 'content.dart';

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
                Expanded(
                  flex: 3,
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
                                      top: kAppSize(context).height * 0.07),
                                  height: kAppSize(context).height * 0.45,
                                  child: Image.asset(
                                    onboardingContents[index].image,
                                    fit: BoxFit.fitWidth,
                                    width: kAppSize(context).width,
                                  ),
                                ),
                                const VerticalSpacer(),
                                HorizontalPadding(
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          onboardingContents[index].title,
                                          style: context.headlineLarge.bold,
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: Text(
                                            onboardingContents[index]
                                                .description,
                                            style: context.bodySmall,
                                          ),
                                        ),
                                        if (_currentIndex == 3) CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: moveToMainScreen,
                                          child: Text(
                                            'Or proceed with limited version',
                                            style: context.bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_currentIndex < 1)
                              const Positioned(
                                top: verticalPadding,
                                child: SafeArea(
                                  child: AppLogo(),
                                ),
                              ),
                          ],
                        );
                      }),
                ),
                Expanded(
                  child: VerticalPadding(
                    padding: 25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HorizontalPadding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            spacing: 10,
                            children: [
                              AppFabButton(
                                opacity: _currentIndex < 3 ? 1 : 0.4,
                                onPressed: !value.isLoading
                                    ? () async {
                                        moveToMainScreen(
                                          isSkip: true,
                                          value: value,
                                        );
                                      }
                                    : null,
                              ),
                              Expanded(
                                child: TranslatorPrimaryButton(
                                  size: double.infinity,
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
                              const SizedBox(width: 50),
                            ],
                          ),
                        ),
                        const Spacer(),
                        VerticalPadding(
                          child: SizedBox(
                            height: 10,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: kAppSize(context).width * 0.45),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: onboardingContents.length,
                                itemBuilder: (context, index) => BuildDotWidget(
                                  index: index,
                                  currentIndex: _currentIndex,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _buildPrivacyPolicyWidgets(context),
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

  Future<void> _restore() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
    );
    await context.read<SubscriptionCubit>().restore(
      onDone: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("You're all set"),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  moveToMainScreen();
                },
                isDefaultAction: true,
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      },
      onError: () {
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Something went wrong"),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: true,
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showNextContents(AuthenticationViewModel value,
      {bool? canLogin = false}) async {
    switch (_currentIndex) {
      case 0:
        _pageController.animateToPage(_currentIndex + 1,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);

      case 1:
        _pageController.animateToPage(_currentIndex + 1,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);

      case 2:
        context.read<OnboardingPaywallBloc>().add(GetOnboardingPaywallEvent());
        _pageController.animateToPage(_currentIndex + 1,
            duration: const Duration(milliseconds: 400), curve: Curves.linear);
      case 3:
        _makeOnboardingPurchase(
            context.read<OnboardingPaywallBloc>().state.product!.productId);
    }

  }

  Future<void> _makeOnboardingPurchase(String productId) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
    );

    await context.read<SubscriptionCubit>().makePurchase(
      productId,
      onDone: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("You're all set"),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                  moveToMainScreen();
                },
                isDefaultAction: true,
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      },
      onError: () {
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Something went wrong"),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isDefaultAction: true,
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> moveToMainScreen(
      {bool isSkip = false, AuthenticationViewModel? value}) async {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (_) => const MainScreen(),
      ),
      (e) => false,
    );
    if (isSkip) {
      await value!.login();
    }
  }

  void _showLinkModalPopUp(String link) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoPopupSurface(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CupertinoButton(
                padding: const EdgeInsets.only(right: 16),
                onPressed: Navigator.of(context).pop,
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    color: CupertinoColors.activeBlue,
                  ),
                ),
              ),
              Expanded(
                child: WebViewWidget(
                  controller: WebViewController()
                    ..loadRequest(
                      Uri.parse(link),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicyWidgets(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SplashActions(
            onTap: () => _showLinkModalPopUp(
                'https://www.freeprivacypolicy.com/live/6eb3b6d3-c82a-44a7-88b1-d27a2fd6055b'),
            text: 'Terms of Use',
          ),
          const HorizontalSpacer(),
          SplashActions(
            onTap: () => _showLinkModalPopUp(
                'https://www.freeprivacypolicy.com/live/a2d6d5ca-4ffb-4422-aa0e-c95ae78e9987'),
            text: 'Privacy Policy',
          ),
          const HorizontalSpacer(),
          SplashActions(
            onTap: _restore,
            text: 'Restore',
          ),
        ],
      ),
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
      padding: const EdgeInsets.all(2.5),
      child: Container(
        width: currentIndex == index ? 12 : 7,
        decoration: BoxDecoration(
          shape: currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
          borderRadius: currentIndex == index ? BorderRadius.circular(4) : null,
          gradient: currentIndex == index ? kPrimaryGradient : null,
          color: currentIndex == index
              ? null
              : kPrimaryColor1.withValues(alpha: .3),
        ),
      ),
    );
  }
}
