import '../features/authentication/presentation/viewmodel/authentication_viewmodel.dart';
import '../features/authentication/presentation/viewmodel/user_provider.dart';
import 'app.dart';

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
