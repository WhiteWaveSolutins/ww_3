import 'package:ai_translator/src/features/main/logic/model.dart';
import 'package:ai_translator/src/service-locators/history/history.dart';
import 'package:ai_translator/src/shared/utils/disposable_change_notifier.dart';

class HistoryViewmodel extends DisposableChangeNotifier {
  HistoryItemList? historyItemList;

  getHistoryItem() {
    historyItemList = historyRepo.getTranslationHistory();
  }

  deleteHistoryItem(HistoryItem item) {
    historyRepo.deleteHistory(item);
  }

  addHistoryItem(HistoryItem item) {
    historyRepo.saveTranslationHistoryToLocal(item);
  }

  addMultipleHistoryItem(List<HistoryItem> items) {
    historyRepo.saveMultipleTranslationHistoryToLocal(items);
  }

  addDummyHistory() {
    historyRepo.saveMultipleTranslationHistoryToLocal(_dummyHistory);
  }

  @override
  void disposeValues() {}
}

final _dummyHistory = [
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'a very long text',
      translation:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...'),
  HistoryItem(
      countries: ['usa', 'france'],
      word:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, Lorem ipsum dolor sit amet, consectetuer adipiscing elit..., Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
];
