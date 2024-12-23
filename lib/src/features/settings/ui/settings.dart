import 'package:ai_translator/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import 'package:ai_translator/src/features/onboarding/onboarding/onboarding.dart';
import 'package:ai_translator/src/features/terms/privacy_policy.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/drop_down.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    return Consumer<AuthenticationViewModel>(
      builder: (context, value, child) => AppBackground(
        imageBg: sMainBg,
        child: SafeArea(
          child: VerticalPadding(
            child: HorizontalPadding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppbackButton(),
                      const HeaderText(
                        text: 'Settings',
                      ),
                      AppFabButton(
                          bgColor: kSecondaryFade1.withOpacity(0.1),
                          icon: CupertinoIcons.square_arrow_left,
                          iconColor: kTabFade1,
                          onPressed: () async {
                            await value.logout();
                            goToLogin();
                          }),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: kAppsize(context).height * 0.09,
                        margin: EdgeInsets.only(top: verticalPadding),
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(bigBorderRadius),
                            gradient: kPrimaryGradient),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Get free trial for a week',
                              style: context.bodyMedium
                                  .copyWith(color: kTextColorDarkMode),
                            ),
                            CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: kTextColorDarkMode,
                                      borderRadius:
                                          BorderRadius.circular(15.sp)),
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
                      VerticalSpacer(
                        space: 40.h,
                      ),
                      const Text(
                        'About App',
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding, vertical: 4.h),
                        margin: EdgeInsets.only(top: smallVerticalPadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.sp),
                            color: kSecondaryFade1.withOpacity(0.1)),
                        child: SettingsText(
                          text: 'Privacy Policy and terms of use',
                          onTap: () {
                            Navigator.restorablePushNamed(
                                context, PrivacyPolicyScreen.routeName);
                          },
                        ),
                      ),
                      VerticalSpacer(
                        space: 40.h,
                      ),
                      const Text(
                        'The Main Ones',
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: horizontalPadding,
                            right: horizontalPadding,
                            top: verticalPadding,
                            bottom: smallVerticalPadding),
                        margin: EdgeInsets.only(top: smallVerticalPadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.sp),
                            color: kSecondaryFade1.withOpacity(0.1)),
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
                      Container(
                        padding: EdgeInsets.all(1.h),
                        margin: EdgeInsets.only(top: bigPadding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.sp),
                            gradient: kPrimaryGradient),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: textSize),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.sp),
                              color: kBackgroundColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Remove history every month',
                                style: context.bodySmall,
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
                    ],
                  ),
                  const Spacer(),
                  const AppLogo(
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goToLogin() {
    Navigator.pushNamedAndRemoveUntil(
        context, OnboardingScreen.routeName, (e) => false);
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Text(
        text,
        style: context.displayLarge,
      ),
    );
  }
}

class AppbackButton extends StatelessWidget {
  const AppbackButton({
    super.key,
    this.color,
    this.onPressed,
  });
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed ??
            () {
              Navigator.pop(context);
            },
        child: SvgPicture.asset(sBackButton));
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
              SvgPicture.asset(sArrowRight),
            ],
          ),
          if (hasDivider!) const AppDivider()
        ],
      ),
    );
  }
}
