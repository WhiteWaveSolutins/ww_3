import 'package:ai_translator/src/service-locators/app.dart';
import 'package:ai_translator/src/service-locators/settings/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServiceLocator.initialize();
  await userSettingsController.loadSettings();
  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  ]).then((value) {
    runApp(
      const MyApp(),
    );
  });
}
