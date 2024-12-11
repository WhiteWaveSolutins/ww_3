import 'package:ai_translator/src/features/translate/logic/api.dart';
import 'package:ai_translator/src/features/translate/logic/speech_util.dart';
import 'package:ai_translator/src/features/translate/logic/text_to_speech.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/service-locators/app.dart';

RecordingViewModel get recordingViewModel =>
    serviceLocator<RecordingViewModel>();

class TransaltorServiceLocator {
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
