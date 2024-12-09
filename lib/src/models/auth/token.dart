import 'package:ai_translator/src/models/auth/response/profile.dart';

class TranslatorToken {
  TranslatorToken({
    required this.token,
    required this.user,
  });

  final LoginUser? user;
  final String? token;

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user?.toJson(),
    };
  }

  factory TranslatorToken.fromJson(Map<String, dynamic> json) {
    return TranslatorToken(
      token: json['token'],
      user: json['user'] == null
          ? null
          : LoginUser.fromJson(
              json['user'],
            ),
    );
  }

  TranslatorToken copyWithToken(String? token) {
    return TranslatorToken(
      token: token,
      user: user,
    );
  }

  TranslatorToken copyWithUser(LoginUser? user) {
    return TranslatorToken(
      token: token,
      user: user,
    );
  }
}
