import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();

  Future<bool> initialize() async {
    return await _speechToText.initialize();
  }

  void startListening({
    required Function(String) onResult,
    required Function() onTimeout,
    Duration timeout = const Duration(seconds: 10),
  }) {
    _speechToText.listen(
      onResult: (result) => onResult(result.recognizedWords),
      listenOptions: SpeechListenOptions(
        enableHapticFeedback: true,
        autoPunctuation: true,
      ),
    );

    Timer(timeout, () {
      _speechToText.stop();
      onTimeout();
    });
  }

  void stopListening() {
    _speechToText.stop();
  }
}
