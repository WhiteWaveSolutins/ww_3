import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../shared/utils/assets.dart';
import '../../../shared/utils/size_utils.dart';
import '../../../shared/utils/text_theme.dart';
import '../../../shared/utils/theme.dart';
import '../../../shared/widgets/buttons.dart';
import '../../../shared/widgets/drop_down.dart';
import '../../../shared/widgets/scaffold.dart';
import '../../../shared/widgets/textfields.dart';
import '../../authentication/presentation/viewmodel/authentication_viewmodel.dart';
import '../../onboarding/onboarding/onboarding.dart';
import '../../terms/privacy_policy.dart';

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

  Future<void> _rate() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    }
  }

  bool isSwitched = false;


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
                      const AppBackButton(),
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
                      const SizedBox(height: 35),
                      // const Text('About App'),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: horizontalPadding, vertical: 4),
                      //   margin:
                      //       const EdgeInsets.only(top: smallVerticalPadding),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(24),
                      //     color: kSecondaryFade1.withValues(alpha: .1),
                      //   ),
                      //   child: SettingsText(
                      //     text: 'Privacy Policy and terms of use',
                      //     onTap: () {
                      //       Navigator.restorablePushNamed(
                      //           context, PrivacyPolicyScreen.routeName);
                      //     },
                      //   ),
                      // ),
                      // const VerticalSpacer(space: 40),
                      const Text(
                        'The Main Ones',
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: horizontalPadding,
                            right: horizontalPadding,
                            top: verticalPadding,
                            bottom: smallVerticalPadding),
                        margin:
                            const EdgeInsets.only(top: smallVerticalPadding),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: kSecondaryFade1.withValues(alpha: .1),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Version',
                                  style: context.bodyMedium,
                                ),
                                Text(
                                  '${AppInfo.of(context).package.versionWithoutBuild}',
                                  style: context.bodyMedium,
                                ),
                              ],
                            ),
                            const AppDivider(),
                            SettingsText(
                              onTap: () async {
                                await FlutterEmailSender.send(
                                  Email(
                                    recipients: ['elisgrop@outlook.com'],
                                    subject: 'Message to support',
                                    body: 'Your feedback',
                                  ),
                                );
                              },
                              text: 'Support',
                              hasDivider: true,
                            ),
                            SettingsText(
                              onTap: _rate,
                              text: 'Rate App',
                              hasDivider: true,
                            ),
                            SettingsText(
                              onTap: () => _showLinkModalPopUp('https://www.freeprivacypolicy.com/live/6eb3b6d3-c82a-44a7-88b1-d27a2fd6055b'),
                              text: 'Terms of Use',
                              hasDivider: true,
                            ),
                            SettingsText(
                              onTap: () => _showLinkModalPopUp('https://www.freeprivacypolicy.com/live/a2d6d5ca-4ffb-4422-aa0e-c95ae78e9987'),
                              text: 'Privacy Policy',
                              hasDivider: false,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.only(top: bigPadding),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: kPrimaryGradient,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: textSize,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: kBackgroundColor,
                          ),
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

class AppBackButton extends StatelessWidget {
  const AppBackButton({
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
