import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/models/auth/response/profile.dart';
import 'package:ai_translator/src/service-locators/app.dart';
import 'package:ai_translator/src/service-locators/authentication.dart';
import 'package:ai_translator/src/shared/utils/disposable_change_notifier.dart';

class AuthenticationViewModel extends DisposableChangeNotifier {
  AuthenticationViewModel();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<bool> login() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 3), () {});
    const token = '12343rdkndndkndk';
    final loginUser =
        LoginUser(id: 1, name: 'Awesome User', email: 'user@email.com');
    userStateProvider.tokenRepo.saveTokenWithUser(token, loginUser);
    await userStateProvider.refresh();
    isLoading = false;
    return true;
  }

  Future<bool> logout() async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 3), () {});
    userStateProvider.logout();
    userStateProvider.tokenRepo.clearCache();
    serviceLocator<RecordingViewModel>().disposeValues();
    await userStateProvider.refresh();
    isLoading = false;
    return true;
  }

  @override
  void disposeValues() {}
}
