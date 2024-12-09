import 'package:ai_translator/src/features/onboarding/splash/splash.dart';
import 'package:ai_translator/src/features/terms/privacy_policy.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
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

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
      appBar: CupertinoNavigationBar(
        leading: const AppbackButton(),
        middle: Text(
          'Settings',
          style: context.displayLarge,
        ),
        trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: const Icon(CupertinoIcons.settings)),
      ),
      body: HorizontalPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: kAppsize(context).height * 0.1,
                  margin: EdgeInsets.only(top: verticalPadding),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(bigBorderRadius),
                      gradient: kPrimaryGradient),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Get free trial for a week',
                        style: context.bodyLarge
                            .copyWith(color: kTextColorDarkMode),
                      ),
                      CupertinoButton(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: kTextColorDarkMode,
                                borderRadius: BorderRadius.circular(15.fSize)),
                            child: Text(
                              'Upgrade',
                              style: context.bodyMedium
                                  .copyWith(color: kPrimaryColor1),
                            ),
                          ),
                          onPressed: () {})
                    ],
                  ),
                ),
                const VerticalPadding(
                  child: Text(
                    'About App',
                  ),
                ),
                VerticalPadding(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding, vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(bigBorderRadius),
                        color: kSecondaryFade1.withOpacity(0.05)),
                    child: SettingsText(
                      text: 'Privacy Policy and terms of use',
                      onTap: () {
                        Navigator.restorablePushNamed(
                            context, PrivacyPolicyScreen.routeName);
                      },
                    ),
                  ),
                ),
                const VerticalPadding(
                  child: Text(
                    'The Main Ones',
                  ),
                ),
                VerticalPadding(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(bigBorderRadius),
                        color: kSecondaryFade1.withOpacity(0.05)),
                    child: const Column(
                      children: [
                        SettingsText(
                          text: 'Version',
                          hasDivider: true,
                        ),
                        SettingsText(
                          text: 'Support',
                          hasDivider: true,
                        ),
                        SettingsText(
                          text: 'Share App',
                          hasDivider: true,
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalPadding(
                  child: Container(
                    padding: EdgeInsets.all(1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(bigBorderRadius),
                        gradient: kPrimaryGradient),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding, vertical: textSize),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(bigBorderRadius),
                          color: kBackgroundColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Remove History Every Month',
                          ),
                          CupertinoSwitch(
                              value: isSwitched,
                              thumbColor: kPrimaryColor1,
                              onChanged: (s) {
                                isSwitched = s;
                                setState(() {});
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const AppLogo(
              mainAxisAlignment: MainAxisAlignment.center,
            )
          ],
        ),
      ),
    );
  }
}

class AppbackButton extends StatelessWidget {
  const AppbackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        child: SvgPicture.asset(sBackButton),
        onPressed: () {
          Navigator.pop(context);
        });
  }
}

class SettingsText extends StatelessWidget {
  const SettingsText({
    super.key,
    required this.text,
    this.onTap,
    this.hasDivider = false,
  });
  final String text;
  final void Function()? onTap;
  final bool? hasDivider;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: context.bodyMedium,
              ),
              HorizontalPadding(child: SvgPicture.asset(sArrowRight)),
            ],
          ),
          if (hasDivider!) const AppDivider()
        ],
      ),
    );
  }
}
