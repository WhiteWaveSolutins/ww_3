import 'dart:async';

import 'package:ai_translator/src/features/main/presentation/viewmodel/history_viewmodel.dart';
import 'package:ai_translator/src/features/main/data/model.dart';
import 'package:ai_translator/src/features/translate/logic/api.dart';
import 'package:ai_translator/src/features/translate/logic/speech_util.dart';
import 'package:ai_translator/src/features/translate/logic/text_to_speech.dart';
import 'package:ai_translator/src/service-locators/app.dart';
import 'package:ai_translator/src/shared/utils/disposable_change_notifier.dart';
import 'package:ai_translator/src/shared/utils/strings.dart';
import 'package:flutter/material.dart';

class RecordingViewModel extends DisposableChangeNotifier {
  final SpeechService _speechService;
  final TextToSpeechService _ttsService;
  final TranslationService _apiService;

  RecordingViewModel(
    this._speechService,
    this._ttsService,
    this._apiService,
  );

  bool _isActive = false;
  bool _isListening = false;
  bool _isTranslating = false;
  String _spokenText = '';
  List<String> _translatedTextAndSpeech = [];
  bool _speechEnabled = false;

  bool _isPlayingAudio = false;

  List<HistoryItem> historyItems = [];

  final _languages = supportedLanguages;

  List<Map<String, String>> get languages => _languages;

  final TextEditingController textEditingController = TextEditingController();

  String _translatedLanguage = 'ru';
  String _fromLanguage = 'en';

  Map<String, String> _outputLang = {
    'name': 'Russian',
    'code': 'ru',
    'flag': '🇷🇺'
  };

  Map<String, String> _inputLang = {
    'name': 'English',
    'code': 'en',
    'flag': '🇬🇧'
  };

  Map<String, String> get outputLang => _outputLang;
  Map<String, String> get inputLang => _inputLang;

  String get translatedLanguage => _translatedLanguage;
  String get fromLanguage => _fromLanguage;

  String get spokenText => _spokenText;
  List<String> get translatedTextAndSpeech => _translatedTextAndSpeech;
  bool get isListening => _isListening;
  bool get isTranslating => _isTranslating;
  bool get speechEnabled => _speechEnabled;
  bool get isPlayingAudio => _isPlayingAudio;
  bool get isActive => _isActive;

  set isActive(bool val) {
    _isActive = val;
    notifyListeners();
  }

  set isPlayingAudio(bool val) {
    _isPlayingAudio = val;
    notifyListeners();
  }

  set isTranslating(bool val) {
    _isTranslating = val;
    notifyListeners();
  }

  Timer? _debounceTimer;

  Timer? _debounceTextTimer;

  Future<void> initializeSpeech() async {
    _speechEnabled = await _speechService.initialize();
    notifyListeners();
  }

  void startListening(
      {required String targetLanguage, required String fromLanguage}) {
    if (_speechEnabled) {
      _isListening = true;
      notifyListeners();

      _speechService.startListening(
        onResult: (result) {
          if (_spokenText != result) {
            _spokenText = result;
            notifyListeners();
            if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
            _debounceTimer = Timer(const Duration(seconds: 1), () {
              if (_spokenText.isNotEmpty) {
                // Stop listening and trigger translation
                _speechService.stopListening();
                _isListening = false;
                notifyListeners();

                // Translate the recognized text
                translateText(canSave: true, isSpeaking: true);
              }
            });
          }
        },
        onTimeout: () {
          stopListening();
        },
      );
    }
    _spokenText = '';
  }

  // Function to handle debounced API calls
  void onTextChanged(String text, Function(String) callback) {
    // Cancel the previous debounce timer, if active
    if (_debounceTextTimer?.isActive ?? false) {
      _debounceTextTimer!.cancel();
    }

    // Start a new debounce timer
    _debounceTextTimer = Timer(const Duration(milliseconds: 200), () {
      // Call the callback function after the debounce delay
      callback(text);
    });
  }

  void stopListening() {
    _isListening = false;
    _speechService.stopListening();
    notifyListeners();
  }

  Future<void> translateText(
      {bool? isSpeaking = false,
      bool? canSave = false,
      String? imageText = ''}) async {
    if (imageText!.isNotEmpty ||
        _spokenText.isNotEmpty ||
        textEditingController.text.trim().isNotEmpty) {
      isTranslating = true;
      final text = imageText.isNotEmpty
          ? imageText
          : isSpeaking!
              ? _spokenText
              : textEditingController.text.trim();

      try {
        _translatedTextAndSpeech =
            await _apiService.translateText(text, translatedLanguage);
      } catch (e) {
        debugPrint("Translation Error: $e");
      } finally {
        isTranslating = false;
        final historyItem = HistoryItem(
          countries: [fromLanguage, translatedLanguage],
          word: text,
          translation: _translatedTextAndSpeech[0],
          soundPath: _translatedTextAndSpeech[1],
        );
        if (canSave!) {
          historyItems.add(historyItem);
          serviceLocator<HistoryViewmodel>()
              .addMultipleHistoryItem(historyItems);
        }
        notifyListeners();
      }
    }
  }

  Future<void> playTranslatedText() async {
    if (_translatedTextAndSpeech.isNotEmpty &&
        _translatedTextAndSpeech.length > 1) {
      isPlayingAudio = true;
      await _ttsService.playAudio(_translatedTextAndSpeech[1]);
      await Future.delayed(const Duration(seconds: 2), () {
        isPlayingAudio = false;
      });
    }
  }

//to set the input lang
  void setInputLanguage(Map<String, String> languageCode) {
    _inputLang = languageCode;
    _fromLanguage = languageCode['code']!;
    notifyListeners();
  }

  void setOutputLanguage(Map<String, String> languageCode) {
    _outputLang = languageCode;
    _translatedLanguage = languageCode['code']!;
    notifyListeners();
  }

  void resetTranslation() {
    _spokenText = '';
    _translatedTextAndSpeech = [];
    textEditingController.text = '';
    _isActive = false;

    notifyListeners();
  }

  @override
  void disposeValues() {
    resetTranslation();
    historyItems = [];
    _debounceTextTimer?.cancel();
    _debounceTimer?.cancel();
  }
}
