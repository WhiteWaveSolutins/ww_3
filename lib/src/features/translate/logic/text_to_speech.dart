import 'dart:developer';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_tts/flutter_tts.dart';

AudioPlayer? _audioPlayer;

class TextToSpeechService {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> playText(String text, String languageCode) async {
    try {
      var isLanguageAvailable =
          await _flutterTts.isLanguageAvailable(languageCode);

      if (isLanguageAvailable) {
        await _flutterTts.setLanguage(languageCode);
        await _flutterTts.setSpeechRate(0.5);
        await _flutterTts.speak(text);
      } else {
        log('Language $languageCode is not available on this device.');
      }
    } catch (ex) {
      log('Unexpected error: $ex');
    }
  }

  Future<Duration> playAudio(String path, {required bool stopPlaying}) async {
    _audioPlayer ??= AudioPlayer();

    if (stopPlaying) {
      await _audioPlayer?.stop();
      return Duration.zero;
    } else {
      await _audioPlayer?.setFilePath(path);
      await _audioPlayer?.play();
      await _audioPlayer?.setVolume(1.0);

      await _audioPlayer?.stop();
      return _audioPlayer?.duration ?? Duration.zero;
    }
  }
}
