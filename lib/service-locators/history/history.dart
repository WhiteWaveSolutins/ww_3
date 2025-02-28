import '../../features/main/data/local_history.dart';
import '../../features/main/presentation/viewmodel/history_viewmodel.dart';
import '../app.dart';

HistoryViewmodel get historyViewModel => HistoryViewmodel();
HistoryRepo get historyRepo => HistoryRepoImpl();

class HistoryServiceLocator {
  static Future<void> initialize() async {
    serviceLocator.registerFactory<HistoryViewmodel>(() => HistoryViewmodel());
    serviceLocator.registerLazySingleton<HistoryRepo>(() => HistoryRepoImpl());
  }
}
