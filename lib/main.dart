import 'package:ai_translator/src/service-locators/app.dart';
import 'package:ai_translator/src/shared/utils/app_providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServiceLocator.initialize();

  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  ]).then((value) {
    runApp(
      MultiProvider(
        providers: [...appProviders],
        child: const MyApp(),
      ),
    );
  });
}
