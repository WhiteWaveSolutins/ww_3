import 'dart:io';

import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:intl/intl.dart';

class StringUtils {
  static String truncateString(String stringToCut, int lengthToCutTo) {
    if (stringToCut.length > lengthToCutTo) {
      return "${stringToCut.substring(0, lengthToCutTo)}...";
    }
    return stringToCut;
  }

  static String formatApiDate(String date, {bool isHttpDate = true}) {
    var parseDate = isHttpDate ? HttpDate.parse(date) : DateTime.parse(date);
    var formattedDate = DateFormat('EEE, MMM d, yyyy').format(parseDate);
    return formattedDate;
  }

  static String formatDate(String val,
      {bool? showTimeStamp = true, bool? showOnlyTime = false}) {
    String amOrPm = '';
    final dateFormat = DateFormat('EEE, dd MMM, yyy');
    if (val.isEmpty) {
      return '';
    } else {
      final date = DateTime.parse(val);
      amOrPm = date.hour > 11 ? 'PM' : 'AM';
      return '${dateFormat.format(date)} at ${DateFormat(' HH:mm').format(date)}$amOrPm';
    }
  }

  static String getInitials(String value, String value2) {
    if (value.isNotEmpty && value2.isNotEmpty) {
      return '${value[0].toUpperCase()}${value2[0].toUpperCase()}';
    } else {
      return '';
    }
  }

  static String formatCurrencyInput(
    String amount,
  ) {
    final formatter = NumberFormat.currency(
      locale: "ru",
      name: 'RUS',
      symbol: ruble,
      decimalDigits: 2,
    );
    amount = amount.replaceAll(RegExp(r'[^0-9\.]'), "");
    final amountDouble = double.tryParse(amount);
    if (amountDouble == null) {
      return "";
    }
    return formatter.format(amountDouble);
  }

  static String formatNumber(String amount) {
    NumberFormat numberFormat = NumberFormat("#,##0", "ru");
    final returnedAmount = numberFormat.format(double.parse(amount));
    return returnedAmount;
  }

  static String timeOfDay() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Morning";
    } else if (hour < 17) {
      return "Afternoon";
    }
    return "Evening";
  }

  static String capitalize(String value) {
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }

  static String formatTimeInMinutes(Duration duration) {
    return "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}";
  }

  String splitAndJoinEachUpperCase(String value) {
    return value
        .split(
          RegExp('(?=[A-Z])'),
        )
        .join(' ');
  }
}
