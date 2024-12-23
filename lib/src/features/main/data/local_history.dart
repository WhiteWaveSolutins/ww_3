import 'dart:convert';
import 'dart:developer';

import 'package:ai_translator/src/features/main/data/model.dart';
import 'package:ai_translator/src/service-locators/app.dart';

abstract class HistoryRepo {
  HistoryItemList getTranslationHistory();
  Future<bool> saveTranslationHistoryToLocal(HistoryItem history);
  Future<bool> saveMultipleTranslationHistoryToLocal(
      List<HistoryItem> histories);
  Future<bool> deleteHistory(HistoryItem history);
}

class HistoryRepoImpl implements HistoryRepo {
  HistoryRepoImpl();

  final sharedPreferences = sharedPrefs;
  @override
  HistoryItemList getTranslationHistory() {
    return _getTokenObjectFromStorage();
  }

  HistoryItemList _getTokenObjectFromStorage() {
    try {
      final jsonString = sharedPreferences.getString('history');
      if (jsonString == null) {
        return HistoryItemList(histories: []);
      }

      final tokenToGet =
          HistoryItemList.fromMap(const JsonDecoder().convert(jsonString));
      return tokenToGet;
    } catch (err, st) {
      log(err.toString());
      log(st.toString());
      return HistoryItemList(histories: []);
    }
  }

  @override
  Future<bool> deleteHistory(history) async {
    final r = _getTokenObjectFromStorage();
    if (r.histories.contains(history)) {
      r.histories.remove(history);
    }
    return await sharedPreferences.setString('history', jsonEncode(r.toMap()));
  }

  @override
  Future<bool> saveTranslationHistoryToLocal(HistoryItem history) async {
    final r = _getTokenObjectFromStorage();
    if (!r.histories.contains(history)) {
      r.histories.add(history);
    }
    return await sharedPreferences.setString('history', jsonEncode(r.toMap()));
  }

  @override
  Future<bool> saveMultipleTranslationHistoryToLocal(
      List<HistoryItem> histories) async {
    final r = _getTokenObjectFromStorage();
    r.histories.addAll(histories);
    return await sharedPreferences.setString('history', jsonEncode(r.toMap()));
  }
}
