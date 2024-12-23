import 'package:ai_translator/src/service-locators/settings/settings.dart';
import 'package:ai_translator/src/shared/utils/route.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            theme: checkTheme(),
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            onGenerateRoute: (RouteSettings routeSettings) {
              return routeConfig(routeSettings, context);
            },
          );
        },
      ),
    );
  }

  CupertinoThemeData checkTheme() {
    return userSettingsController.themeMode == ThemeMode.dark
        ? translatorDarkTheme
        : translatorLightTheme;
  }
}
