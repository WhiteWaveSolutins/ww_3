// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginSuccessResponse {
  String? message;
  String token;
  String? email;
  String? userName;
  int? type;
  LoginSuccessResponse({
    this.message,
    required this.token,
    this.email,
    this.userName,
    this.type,
  });

  LoginSuccessResponse copyWith({
    String? message,
    String? token,
    String? email,
    String? userName,
    int? type,
  }) {
    return LoginSuccessResponse(
      message: message ?? this.message,
      token: token ?? this.token,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'auth_token': token,
      'email': email,
      'name': userName,
      'type': type,
    };
  }

  factory LoginSuccessResponse.fromMap(Map<String, dynamic> map) {
    return LoginSuccessResponse(
      message: map['message'] ?? '',
      token: map['token'] as String,
      email: map['email'] ?? '',
      userName: map['name'] ?? '',
      type: map['type'] ?? 5,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSuccessResponse.fromJson(String source) =>
      LoginSuccessResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginSuccessResponse(message: $message, authToken: $token, email: $email, userName: $userName, type: $type)';
  }

  @override
  bool operator ==(covariant LoginSuccessResponse other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.token == token &&
        other.email == email &&
        other.userName == userName &&
        other.type == type;
  }

  @override
  int get hashCode {
    return message.hashCode ^
        token.hashCode ^
        email.hashCode ^
        userName.hashCode ^
        type.hashCode;
  }
}
