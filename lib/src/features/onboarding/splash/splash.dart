import 'package:ai_translator/src/features/onboarding/onboarding/onboarding.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    gotoOnboarding();
  }

  void gotoOnboarding() async =>
      await Future.delayed(const Duration(seconds: 2), () {
        onboardingRoute();
      });

  void onboardingRoute() {
    Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: kAppsize(context).height * 0.12,
              left: 0,
              right: 0,
              child: Image.asset(sLogoPng),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PrivacyPolicyWidgets(),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyWidgets extends StatelessWidget {
  const PrivacyPolicyWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SplashActions(
            onTap: () {},
            text: 'Terms of Use',
          ),
          const HorizontalSpacer(),
          SplashActions(
            onTap: () {},
            text: 'Privacy Policy',
          ),
          const HorizontalSpacer(),
          SplashActions(
            onTap: () {},
            text: 'Restore',
          ),
        ],
      ),
    );
  }
}
