import '../../features/translate/logic/api.dart';
import '../../features/translate/logic/speech_util.dart';
import '../../features/translate/logic/text_to_speech.dart';
import '../../features/translate/logic/viewmodel.dart';
import '../app.dart';

RecordingViewModel get recordingViewModel =>
    serviceLocator<RecordingViewModel>();

class TranslatorServiceLocator {
  static Future<void> initialize() async {
    serviceLocator.registerLazySingleton<RecordingViewModel>(() =>
        RecordingViewModel(
            serviceLocator(), serviceLocator(), serviceLocator()));
    serviceLocator.registerLazySingleton<SpeechService>(() => SpeechService());
    serviceLocator.registerLazySingleton<TextToSpeechService>(
        () => TextToSpeechService());
    serviceLocator
        .registerLazySingleton<TranslationService>(() => TranslationService());
  }
}
