import 'package:ai_translator/src/models/auth/response/profile.dart';
import 'package:ai_translator/src/models/auth/token.dart';
import 'package:ai_translator/src/service-locators/app.dart';
import 'package:ai_translator/src/shared/utils/disposable_change_notifier.dart';

class UserStateProvider extends DisposableChangeNotifier {
  UserStateProvider();
  final tokenRepo = userState;
  UserAuthStatus _authStatus = UserAuthStatus.unauthenticated;
  UserAuthStatus get authStatus => _authStatus;
  set authStatus(UserAuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  bool _firstTimeUser = true;
  bool get firstTimeUser => _firstTimeUser;
  set firstTimeUser(bool value) {
    _firstTimeUser = value;
    notifyListeners();
  }

  LoginUser? _currentUser;
  LoginUser? get currentUser => _currentUser;
  set currentUser(LoginUser? value) {
    _currentUser = value;
    notifyListeners();
  }

  TranslatorToken _currentToken = TranslatorToken(token: null, user: null);
  TranslatorToken get currentToken => _currentToken;
  set currentToken(TranslatorToken value) {
    _currentToken = value;
    notifyListeners();
  }

  Future<void> init() async {
    currentToken = tokenRepo.getToken();
    currentUser = currentToken.user;

    if (currentToken.user != null) {
      firstTimeUser = false;
    }

    if (currentToken.token != null && currentToken.user != null) {
      authStatus = UserAuthStatus.authenticated;
    } else {
      authStatus = UserAuthStatus.unauthenticated;
    }
  }

  Future<void> refresh() async {
    init();
  }

  Future<void> logout() async {
    await tokenRepo.updateToken(currentToken.copyWithToken(null));
    await refresh();
  }

  @override
  void disposeValues() {}
}

enum UserAuthStatus { unauthenticated, authenticated }

@override
void disposeValues() {}
