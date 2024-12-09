import 'package:ai_translator/src/core/network/network.dart';
import 'package:ai_translator/src/routes/observer/observer.dart';
import 'package:ai_translator/src/service-locators/settings/settings.dart';
import 'package:ai_translator/src/services/app/token.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await SettingsServiceLocator.initialize();
    // await AuthServiceLocator.initialize();
  }
}
