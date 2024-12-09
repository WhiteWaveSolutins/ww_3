import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:intl/intl.dart';

class NumberUtil {
  static String currencyFormat(double value, [int precision = 2]) {
    return NumberFormat.currency(
      locale: 'ru',
      symbol: ruble,
      decimalDigits: precision,
    ).format(value);
  }
}
