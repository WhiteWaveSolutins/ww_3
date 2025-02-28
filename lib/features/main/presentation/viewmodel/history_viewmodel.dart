import '../../../../service-locators/history/history.dart';
import '../../../../shared/utils/disposable_change_notifier.dart';
import '../../data/model.dart';

class HistoryViewmodel extends DisposableChangeNotifier {
  HistoryItemList historyItemList = HistoryItemList(histories: []);

  HistoryItem? historyItem;

  final emptyHistoryItem =
      HistoryItem(countries: [], word: '', translations: [], date: '');

  void toggleMenu(HistoryItem item) {
    if (historyItem == item) {
      historyItem = emptyHistoryItem;
    } else {
      historyItem = item;
    }

    notifyListeners();
  }

  HistoryItemList getHistoryItem() {
    var historyItemList = historyRepo.getTranslationHistory();
    var s = historyItemList.histories.reversed.toList();
    final toReturn = HistoryItemList(histories: s);
    return toReturn;
  }

  Future<bool> deleteHistoryItem(HistoryItem item) async {
    final r = await historyRepo.deleteHistory(item);
    getHistoryItem();
    return r;
  }

  addHistoryItem(HistoryItem item) {
    historyRepo.saveTranslationHistoryToLocal(item);
  }

  addMultipleHistoryItem(List<HistoryItem> items) {
    historyRepo.saveMultipleTranslationHistoryToLocal(items);
  }

  // addDummyHistory() {
  //   historyRepo.saveMultipleTranslationHistoryToLocal(_dummyHistory);
  // }

  @override
  void disposeValues() {}
}
