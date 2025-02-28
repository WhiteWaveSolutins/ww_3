import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/api_client.dart';
import '../core/network/token.dart';
import '../core/observer/observer.dart';
import 'authentication.dart';
import 'history/history.dart';
import 'settings/settings.dart';
import 'translate/translate.dart';

GetIt serviceLocator = GetIt.instance;
SharedPreferences get sharedPrefs => serviceLocator<SharedPreferences>();
UserStateRepo get userState => serviceLocator<UserStateRepo>();
ApiClient get apiClient => serviceLocator<ApiClient>();

class AppServiceLocator {
  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    serviceLocator.registerLazySingleton<SharedPreferences>(() => prefs);
    serviceLocator.registerLazySingleton<TranslatorRouteObserver>(
        () => TranslatorRouteObserver());
    serviceLocator
        .registerLazySingleton<UserStateRepo>(() => UserStateRepoImpl());
    serviceLocator.registerLazySingleton<ApiClient>(() => ApiClient());
    await AuthenticationServiceLocator.initialize();
    await SettingsServiceLocator.initialize();
    await TranslatorServiceLocator.initialize();
    await HistoryServiceLocator.initialize();
    await userSettingsController.loadSettings();

    Future.delayed(
      const Duration(milliseconds: 1500),
      () => FlutterNativeSplash.remove(),
    );
  }
}
