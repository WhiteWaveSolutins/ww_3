import 'dart:convert';
import 'dart:developer';

import 'package:ai_translator/src/models/auth/response/profile.dart';
import 'package:ai_translator/src/models/auth/token.dart';
import 'package:ai_translator/src/service-locators/app.dart';

abstract class UserStateRepo {
  TranslatorToken getToken();
  Future<bool> saveTokenWithUser(String? token, LoginUser? user);
  Future<bool> deleteToken();
  Future<bool> updateToken(TranslatorToken token);
  Future<void> clearCache();
}

class UserStateRepoImpl implements UserStateRepo {
  UserStateRepoImpl();

  final sharedPreferences = sharedPrefs;
  @override
  TranslatorToken getToken() {
    return _getTokenObjectFromStorage();
  }

  @override
  Future<bool> saveTokenWithUser(String? token, LoginUser? user) {
    final tokenToSave = TranslatorToken(token: token, user: user);
    return sharedPreferences.setString(
        'token', const JsonEncoder().convert(tokenToSave.toJson()));
  }

  TranslatorToken _getTokenObjectFromStorage() {
    try {
      final jsonString = sharedPreferences.getString('token');
      if (jsonString == null) {
        return TranslatorToken(token: null, user: null);
      }

      final tokenToGet =
          TranslatorToken.fromJson(const JsonDecoder().convert(jsonString));
      return tokenToGet;
    } catch (err) {
      log(err.toString());
      return TranslatorToken(token: null, user: null);
    }
  }

  @override
  Future<bool> deleteToken() async {
    return await sharedPreferences.remove('token');
  }

  @override
  Future<bool> updateToken(TranslatorToken token) async {
    return await sharedPreferences.setString(
        'token', const JsonEncoder().convert(token.toJson()));
  }

  @override
  Future<void> clearCache() async {
    await sharedPreferences.clear();
    await sharedPreferences.reload();
  }
}
