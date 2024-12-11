import 'package:ai_translator/src/features/main/logic/history_viewmodel.dart';
import 'package:ai_translator/src/features/main/logic/local_history.dart';
import 'package:ai_translator/src/service-locators/app.dart';

HistoryViewmodel get historyViewModel => HistoryViewmodel();
HistoryRepo get historyRepo => HistoryRepoImpl();

class HistoryServiceLocator {
  static Future<void> initialize() async {
    serviceLocator.registerFactory<HistoryViewmodel>(() => HistoryViewmodel());
    serviceLocator.registerLazySingleton<HistoryRepo>(() => HistoryRepoImpl());
  }
}
