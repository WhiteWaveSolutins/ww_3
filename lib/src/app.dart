import 'package:ai_translator/src/features/authentication/logic/user_provider.dart';
import 'package:ai_translator/src/features/main/ui/history.dart';
import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/onboarding/onboarding/onboarding.dart';
import 'package:ai_translator/src/features/onboarding/splash/splash.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/terms/privacy_policy.dart';
import 'package:ai_translator/src/features/translate/ui/camera.dart';
import 'package:ai_translator/src/features/translate/ui/record.dart';
import 'package:ai_translator/src/service-locators/settings/settings.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) => ListenableBuilder(
        listenable: userSettingsController,
        builder: (BuildContext context, Widget? child) {
          return CupertinoApp(
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
            ],
            theme: userSettingsController.themeMode == ThemeMode.dark
                ? translatorDarkTheme
                : translatorLightTheme,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            // builder: (context, child) {
            //   final brightness =
            //       userSettingsController.themeMode == ThemeMode.dark
            //           ? Brightness.dark
            //           : userSettingsController.themeMode == ThemeMode.light
            //               ? Brightness.light
            //               : MediaQuery.of(context).platformBrightness;

            //   return CupertinoTheme(
            //     data: brightness == Brightness.dark
            //         ? translatorLightTheme
            //         : translatorLightTheme,
            //     child: child!,
            //   );
            // },
            onGenerateRoute: (RouteSettings routeSettings) {
              return routeConfig(routeSettings, context);
            },
          );
        },
      ),
    );
  }
}

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
        case CameraScreen.routeName:
          return const CameraScreen();
        default:
          return const SplashScreen();
      }
    },
  );
}
