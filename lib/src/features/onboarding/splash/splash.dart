import 'package:ai_translator/src/features/onboarding/onboarding/onboarding.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  State<SplashScreen> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 30),
    )..repeat();
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(sMic),
                    const Text('Voice Translate')
                  ],
                ),
                Center(
                  child: Image.asset(
                    sLogoPng,
                  ),
                ),
              ],
            ),
          ),
          HorizontalPadding(
            padding: kAppsize(context).width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Terms of Use',
                  style: context.bodySmall,
                ),
                Text(
                  'Terms of Use',
                  style: context.bodySmall,
                ),
                Text(
                  'Terms of Use',
                  style: context.bodySmall,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [SvgPicture.asset(sMic), const Text('Voice Translate')],
    );
  }
}
