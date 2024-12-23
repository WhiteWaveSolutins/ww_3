import 'package:ai_translator/src/features/main/data/model.dart';
import 'package:ai_translator/src/service-locators/history/history.dart';
import 'package:ai_translator/src/shared/utils/disposable_change_notifier.dart';

class HistoryViewmodel extends DisposableChangeNotifier {
  HistoryItemList historyItemList = HistoryItemList(histories: []);

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
      soundPath: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
];
