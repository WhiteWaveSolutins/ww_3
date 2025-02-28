import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/authentication/presentation/viewmodel/user_provider.dart';
import '../../features/main/presentation/ui/history.dart';
import '../../features/main/presentation/ui/main.dart';
import '../../features/onboarding/onboarding/onboarding.dart';
import '../../features/settings/ui/settings.dart';
import '../../features/terms/privacy_policy.dart';
import '../../features/translate/ui/image_translate.dart';
import '../../features/translate/ui/record.dart';

MaterialPageRoute<void> routeConfig(
    RouteSettings routeSettings, BuildContext context) {
  String routeName = routeSettings.name!;
  final userStateProv = context.read<UserStateProvider>();
  if (userStateProv.authStatus == UserAuthStatus.authenticated) {
    routeName = MainScreen.routeName;
  }
  return MaterialPageRoute<void>(
    settings: routeSettings,
    builder: (BuildContext context) {
      switch (routeName) {
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
          return const OnboardingScreen();
      }
    },
  );
}
