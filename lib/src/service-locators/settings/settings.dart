import 'package:ai_translator/src/features/settings/logic/local_settings_service.dart';
import 'package:ai_translator/src/features/settings/logic/settings_api.dart';
import 'package:ai_translator/src/features/settings/logic/settings_controller.dart';
import 'package:ai_translator/src/features/settings/logic/settings_service.dart';
import 'package:ai_translator/src/features/settings/logic/settings_viewmodel.dart';
import 'package:ai_translator/src/service-locators/app.dart';

SettingsService get userSettingsService => serviceLocator<SettingsService>();
SettingsController get userSettingsController =>
    serviceLocator<SettingsController>();
SettingsApi get settingsApi => serviceLocator<SettingsApi>();
ApiSettingsService get apiSettingsService =>
    serviceLocator<ApiSettingsService>();
SettingsViewModel get settingsViewModel => serviceLocator<SettingsViewModel>();

class SettingsServiceLocator {
  static Future<void> initialize() async {
    serviceLocator
        .registerLazySingleton<SettingsService>(() => SettingsService());
    serviceLocator.registerLazySingleton<SettingsController>(
        () => SettingsController(serviceLocator()));
    serviceLocator.registerLazySingleton<SettingsApi>(() => SettingsApiImpl());
    serviceLocator.registerLazySingleton<ApiSettingsService>(
        () => ApiSettingsServiceImpl());
    serviceLocator
        .registerFactory<SettingsViewModel>(() => SettingsViewModel());
  }
}
