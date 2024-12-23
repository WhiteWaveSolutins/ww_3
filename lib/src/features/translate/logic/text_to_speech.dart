import 'dart:developer';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
    final player = AudioPlayer();
    if (stopPlaying) {
      await player.stop();
      return Duration.zero;
    } else {
      await player.setFilePath(path);
      await player.play();
// await player.pause();
// await player.seek(Duration(seconds: 10));
      await player.setSpeed(0.1);
      await player.setVolume(1.0);
      await player.stop();
      return player.duration ?? Duration.zero;
    }
  }
}
