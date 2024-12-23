import 'dart:developer';
import 'dart:io';
import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiResponseException implements Exception {
  ApiResponseException(this.message);

  final String message;

  static ApiResponseException getException(err) {
    debugPrint('DioError: ${(err as DioException).message}');
    debugPrint('DioError: ${err.response?.data}');
    switch (err.type) {
      case DioExceptionType.cancel:
        return OtherExceptions(kRequestCancelledError);

      case DioExceptionType.connectionError:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        return InternetConnectException(kTimeOutError);

      case DioExceptionType.unknown:
        if (err.error is FormatException) {
          return FormatException();
        }
        if (err.error is SocketException) {
          return InternetConnectException("No internet connection. Try again");
        }
        break;

      case DioExceptionType.badCertificate:
        return InternetConnectException(kTimeOutError);
      case DioExceptionType.badResponse:
        try {
          if (err.response?.data != null) {
            if ((err.response!.data as Map)['message'] is Map) {
              return OtherExceptions(
                ((err.response!.data as Map)['message'] as Map)['message'],
              );
            }
            return OtherExceptions((err.response!.data as Map)['message']);
          } else {
            switch (err.response?.statusCode) {
              case 500:
                return InternalServerException();
              case 404:
              case 502:
                return OtherExceptions(kNotFoundError);
              case 400:
                return OtherExceptions(kBadRequestError);
              case 403:
              case 401:
                return UnAuthorizedException();
              default:
                // default exception error message
                return OtherExceptions(kDefaultError);
            }
          }
        } catch (err) {
          log(err.toString());
          return OtherExceptions(kDefaultError);
        }
    }
    // default exception error message
    return OtherExceptions(kDefaultError);
  }
}

class OtherExceptions implements ApiResponseException {
  OtherExceptions(this.newMessage);

  final String newMessage;

  @override
  String toString() => message;

  @override
  String get message => newMessage;
}

class FormatException implements ApiResponseException {
  @override
  String toString() => message;

  @override
  String get message => kFormatError;
}

class InternetConnectException implements ApiResponseException {
  InternetConnectException(this.newMessage);

  final String newMessage;

  @override
  String toString() => message;

  @override
  String get message => newMessage;
}

class InternalServerException implements ApiResponseException {
  @override
  String toString() {
    return message;
  }

  @override
  String get message => kServerError;
}

class UnAuthorizedException implements ApiResponseException {
  @override
  String toString() {
    return message;
  }

  @override
  String get message => kUnAuthorizedError;
}

class CacheException implements Exception {
  CacheException(this.message) : super();

  String message;

  @override
  String toString() {
    return message;
  }
}
