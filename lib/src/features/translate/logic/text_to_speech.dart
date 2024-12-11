import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> playText(String text, String languageCode) async {
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setSpeechRate(0.5); // Adjust speed
    await _flutterTts.speak(text);
  }
}
