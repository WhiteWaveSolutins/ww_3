import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/features/translate/ui/text_detector_painter.dart';
import 'package:ai_translator/src/service-locators/app.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'detector_view.dart';

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
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  // ui.Image? _image;
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
        onImage: _processImage,
        initialCameraLensDirection: _cameraLensDirection,
        onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
      ),
      // if (value.isTranslating) const AppLoader()

      // Positioned(
      //     top: 30,
      //     left: 100,
      //     right: 100,
      //     child: Row(
      //       children: [
      //         const Spacer(),
      //         Container(
      //             decoration: BoxDecoration(
      //               color: Colors.black54,
      //               borderRadius: BorderRadius.circular(10.0),
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.all(4.0),
      //               child: _buildDropdown(),
      //             )),
      //         const Spacer(),
      //       ],
      //     )),
    ]);
  }

  // Widget _buildDropdown() => DropdownButton<TextRecognitionScript>(
  //       value: _script,
  //       icon: const Icon(Icons.arrow_downward),
  //       elevation: 16,
  //       style: const TextStyle(color: Colors.blue),
  //       underline: Container(
  //         height: 2,
  //         color: Colors.blue,
  //       ),
  //       onChanged: (TextRecognitionScript? script) {
  //         if (script != null) {
  //           setState(() {
  //             _script = script;
  //             _textRecognizer.close();
  //             _textRecognizer = TextRecognizer(script: _script);
  //           });
  //         }
  //       },
  //       items: TextRecognitionScript.values
  //           .map<DropdownMenuItem<TextRecognitionScript>>((script) {
  //         return DropdownMenuItem<TextRecognitionScript>(
  //           value: script,
  //           child: Text(script.name),
  //         );
  //       }).toList(),
  //     );

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      _textBlocks = recognizedText.blocks;
      await translateBlocksOfImage(serviceLocator<RecordingViewModel>());
      final painter = TextRecognizerPainter(
        recognizedText.blocks,
        _translations,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      // _text = 'Recognized text:\n\n${recognizedText.text}';
      _textBlocks = recognizedText.blocks;
      await translateBlocksOfImage(serviceLocator<
          RecordingViewModel>()); // Get translations even for this case

      final painter = BoundingRectPainter(_textBlocks, _translations);
      _customPaint = CustomPaint(painter: painter);
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
