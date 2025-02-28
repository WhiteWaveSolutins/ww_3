import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'service-locators/settings/settings.dart';
import 'shared/utils/route.dart';
import 'shared/utils/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: userSettingsController,
      builder: (BuildContext context, Widget? child) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          theme: translatorLightTheme,
          onGenerateRoute: (RouteSettings routeSettings) {
            return routeConfig(routeSettings, context);
          },
        );
      },
    );
  }

  CupertinoThemeData checkTheme() {
    return userSettingsController.themeMode == ThemeMode.dark
        ? translatorDarkTheme
        : translatorLightTheme;
  }
}
