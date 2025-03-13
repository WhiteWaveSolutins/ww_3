import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
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

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: MultiProvider(
        providers: [...appProviders],
        child: const MyApp(),
      ),
    ),
  );
}
