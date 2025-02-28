import '../../../../models/auth/response/profile.dart';
import '../../../../service-locators/app.dart';
import '../../../../service-locators/authentication.dart';
import '../../../../shared/utils/disposable_change_notifier.dart';
import '../../../translate/logic/viewmodel.dart';

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
