import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../shared/utils/text_theme.dart';
import '../../../../shared/widgets/scaffold.dart';
import '../../../../shared/widgets/textfields.dart';
import '../../../authentication/presentation/viewmodel/authentication_viewmodel.dart';
import '../../../main/presentation/ui/main.dart';
import '../../../settings/ui/settings.dart';
import '../../cubit/subscription_cubit.dart';
import 'bloc/main_paywall_bloc.dart';
import 'bloc/main_paywall_bloc.dart';

class MainPaywallScreen extends StatefulWidget {
  const MainPaywallScreen({super.key});

  static const routeName = '/mainPaywall';

  @override
  State<MainPaywallScreen> createState() => _MainPaywallScreenState();
}

class _MainPaywallScreenState extends State<MainPaywallScreen> {
  void _init() {
    context.read<MainPaywallBloc>().add(GetMainPaywallEvent());
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Image.asset('assets/images/onboarding-4.png'),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: AppBackButton(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Unlimited access to all languages',
                    textAlign: TextAlign.center,
                    style: context.headlineLarge.bold,
                  ),
                  const SizedBox(height: 30),

                  // Subscription option container
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFF3DB6A0), width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child:  Text(
                                'Weekly Product',
                                style: TextStyle(
                                  color: Color(0xFF3DB6A0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            BlocBuilder<MainPaywallBloc, MainPaywallState>(
                              builder: (context, state) {
                                if (state is LoadMainPaywallState) {
                                  return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF3DB6A0),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        '${state.product!.skProduct!.price}${state.product!.skProduct!.priceLocale.currencySymbol}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ));
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        BlocBuilder<MainPaywallBloc, MainPaywallState>(
                          builder: (context, state) {
                            if (state is LoadMainPaywallState) {
                              return Text(
                                'Try 3 days free, Then ${state.product!.skProduct!.price}${state.product!.skProduct!.priceLocale.currencySymbol}/week',
                                style: const TextStyle(
                                  color: Color(0xFF3DB6A0),
                                  fontSize: 12,
                                ),
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // CTA button
                  BlocBuilder<MainPaywallBloc, MainPaywallState>(
                    builder: (context, state) {
                      if (state is LoadMainPaywallState) {
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () =>
                              _makePurchase(state.product!.productId),
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3DB6A0),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: Text(
                                'Try free & subscribe',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(height: 10),

                  // Footer links
                  _buildPrivacyPolicyWidgets(context),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePurchase(String productId) async {
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
                  context.read<SubscriptionCubit>().checkHasPremiumAccess();
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

  Future<void> moveToMainScreen() async {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (_) => const MainScreen(),
      ),
      (e) => false,
    );
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
