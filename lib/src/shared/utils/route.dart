import 'package:ai_translator/src/features/authentication/presentation/viewmodel/user_provider.dart';
import 'package:ai_translator/src/features/main/presentation/ui/history.dart';
import 'package:ai_translator/src/features/main/presentation/ui/main.dart';
import 'package:ai_translator/src/features/onboarding/onboarding/onboarding.dart';
import 'package:ai_translator/src/features/onboarding/splash/splash.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/terms/privacy_policy.dart';
import 'package:ai_translator/src/features/translate/ui/image_translate.dart';
import 'package:ai_translator/src/features/translate/ui/record.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

MaterialPageRoute<void> routeConfig(
    RouteSettings routeSettings, BuildContext context) {
  String routeName = routeSettings.name!;
  final userStateProv = context.read<UserStateProvider>();
  if (routeSettings.name == SplashScreen.routeName &&
      userStateProv.authStatus == UserAuthStatus.authenticated) {
    routeName = MainScreen.routeName;
  }
  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (BuildContext context) {
      switch (routeName) {
        case SplashScreen.routeName:
          return const SplashScreen();
        case OnboardingScreen.routeName:
          return const OnboardingScreen();
        case MainScreen.routeName:
          return const MainScreen();
        case TranslatorSettingsScreen.routeName:
          return const TranslatorSettingsScreen();
        case PrivacyPolicyScreen.routeName:
          return const PrivacyPolicyScreen();
        case HistoryScreen.routeName:
          return const HistoryScreen();
        case RecordingScreen.routeName:
          return const RecordingScreen();
        case TextRecognizerView.routeName:
          return const TextRecognizerView();
        default:
          return const SplashScreen();
      }
    },
  );
}
