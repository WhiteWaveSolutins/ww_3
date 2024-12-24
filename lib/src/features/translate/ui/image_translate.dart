import 'dart:developer';

import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/features/translate/ui/widgets/detector_view.dart';
import 'package:ai_translator/src/features/translate/ui/widgets/text_detector_painter.dart';
import 'package:ai_translator/src/service-locators/app.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextRecognizerView extends StatefulWidget {
  static const routeName = '/camera';
  const TextRecognizerView({super.key});

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  // var _script = TextRecognitionScript.latin;
  var textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  Widget? _widget;
  String? _text;

  var _cameraLensDirection = CameraLensDirection.back;

  List<TextBlock> _textBlocks = [];
  List<String> _translations = [];

  @override
  void dispose() async {
    _canProcess = false;
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      DetectorView(
        title: 'Text Detector',
        customPaint: _customPaint,
        translations: _translations,
        text: _text,
        widget: _widget,
        onImage: _processImage,
        clearTranslations: clearTranslations,
        initialCameraLensDirection: _cameraLensDirection,
        onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
      ),
      // GalleryView(
      //     title: 'Text Translation',
      //     translations: _translations,
      //     text: _text,
      //     onImage: _processImage,
      //     widget: _widget,
      //     onDetectorViewModeChanged: () {})
    ]);
  }

  void clearTranslations() {
    _widget = null;
    setState(() {});
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;

    setState(() {
      _text = '';
    });

    final recognizedText = await textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      if (_isBusy) return;
      _isBusy = true;
      _textBlocks = recognizedText.blocks;
      await translateBlocksOfImage(serviceLocator<RecordingViewModel>());
      final painter = TextRecognizerPainter(
        _textBlocks,
        _translations,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _textBlocks = recognizedText.blocks;
      log('$_text');
      await translateBlocksOfImage(serviceLocator<RecordingViewModel>());
      final overlay = TextOverlay(
          blocks: recognizedText.blocks,
          translatedTexts: _translations,
          imageSize: Size(200.w, 400.h));
      _widget = overlay;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> translateBlocksOfImage(RecordingViewModel value) async {
    _translations = await _translateTextBlocks(value);
  }

  Future<List<String>> _translateTextBlocks(RecordingViewModel value) async {
    // Combine all block texts into a single string separated by a delimiter
    final combinedText = _textBlocks.map((block) => block.text).join('||');

    await value.translateText(imageText: combinedText, canSave: true);
    final translatedText = value.translatedTextAndSpeech[0];

    // Split translated text back into blocks using the delimiter
    final translations = translatedText.split('||').toList();
    debugPrint('These are the translations::: $translations');
    return translations;
  }
}
