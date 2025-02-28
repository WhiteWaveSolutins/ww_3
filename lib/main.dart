import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'service-locators/app.dart';
import 'shared/utils/app_providers.dart';

Future<void> main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await AppServiceLocator.initialize();

  Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]),
  ]).then(
    (value) {
      runApp(
        MultiProvider(
          providers: [...appProviders],
          child: const MyApp(),
        ),
      );
    },
  );
}
