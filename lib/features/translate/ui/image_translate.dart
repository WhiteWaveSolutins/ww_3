import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../service-locators/app.dart';
import '../logic/viewmodel.dart';
import 'widgets/gallery_view.dart';
import 'widgets/text_detector_painter.dart';

class TextRecognizerView extends StatefulWidget {
  static const routeName = '/camera';
  const TextRecognizerView({super.key});

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  var textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _isBusy = false;
  Widget? _widget;
  String? _text;

  List<TextBlock> _textBlocks = [];
  List<String> _translations = [];

  @override
  void dispose() async {
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GalleryView(
      title: 'Text Translation',
      clearTranslations: clearTranslations,
      translations: _translations,
      text: _text,
      onImage: _processImage,
      widget: _widget,
      onDetectorViewModeChanged: () {},
    );
  }

  void clearTranslations() {
    _widget = null;
    setState(() {});
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (_isBusy) return;

    _isBusy = true;

    try {
      setState(() {
        _text = '';
      });

      final recognizedText = await textRecognizer.processImage(inputImage);

      if (inputImage.metadata?.size != null &&
          inputImage.metadata?.rotation != null) {
        _textBlocks = recognizedText.blocks;
        _translations = recognizedText.text.split('\n');

        if (mounted) {
          setState(() {
            _widget = null;
          });
        }
      } else {
        _textBlocks = recognizedText.blocks;
        await translateBlocksOfImage(serviceLocator<RecordingViewModel>());

        final overlay = TextOverlay(
          blocks: recognizedText.blocks,
          translatedTexts: _translations,
          imageSize: const Size(300, 400),
        );

        if (mounted) {
          setState(
            () {
              _widget = overlay;
              // _customPaint = null; // Clear custom paint to avoid overlap
            },
          );
        }
      }
    } catch (e, stack) {
      log('Error in _processImage: $e, $stack');
    } finally {
      _isBusy = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> translateBlocksOfImage(RecordingViewModel value) async {
    int attempts = 0;
    const maxAttempts = 2;
    bool success = false;

    while (attempts < maxAttempts && !success) {
      try {
        attempts++;
        _translations = await _translateTextBlocks(value);
        success = true;
      } catch (e, stack) {
        log('Error in translateBlocksOfImage (attempt $attempts): $e, $stack');
        if (attempts >= maxAttempts) {
          _translations = [];
        }
      }
    }
  }

  Future<List<String>> _translateTextBlocks(RecordingViewModel value) async {
    final combinedText = _textBlocks.map((block) => block.text).join('||');
    try {
      await value.translateText(imageText: combinedText, canSave: true);

      final translatedText = value.translatedTextAndSpeech.isNotEmpty
          ? value.translatedTextAndSpeech[0]
          : '';
      return translatedText.split('||').toList();
    } catch (e, stack) {
      log('Error in _translateTextBlocks: $e, $stack');
      return [];
    }
  }
}
