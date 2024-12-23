import 'package:ai_translator/src/features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import 'package:ai_translator/src/features/authentication/presentation/viewmodel/user_provider.dart';
import 'package:ai_translator/src/service-locators/app.dart';

UserStateProvider get userStateProvider => UserStateProvider();

class AuthenticationServiceLocator {
  static Future<void> initialize() async {
    serviceLocator
        .registerLazySingleton<UserStateProvider>(() => UserStateProvider());
    serviceLocator<UserStateProvider>().init();
    serviceLocator.registerFactory<AuthenticationViewModel>(
        () => AuthenticationViewModel());
  }
}
