// auth endpoints
import 'package:ai_translator/src/shared/utils/strings.dart';

// endpoints
final authEndpoints = _AuthenticationEndpoints();

class _AuthenticationEndpoints {
  final login = '$kBaseUrl/$kApiVersion/auth/login';
  final register = '$kBaseUrl/$kApiVersion/auth/register';
}
