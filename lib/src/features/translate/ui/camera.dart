import 'dart:io';
import 'dart:ui' as ui;

import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/features/translate/ui/record.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/image_painter.dart';
import 'package:ai_translator/src/shared/widgets/loaders.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  // bool isTranslating = false;
  bool _isCopied = false;

  ui.Image? _image;
  List<TextBlock> _textBlocks = [];
  List<String> _translations = [];

  @override
  void initState() {
    super.initState();
    _pickImage(context.read<RecordingViewModel>());
  }

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
        backgroundColor: kSecondaryFade1.withOpacity(0.15),
        body: Consumer<RecordingViewModel>(
          builder: (context, value, child) => Stack(
            children: [
              SafeArea(
                child: Center(
                  child: _image == null
                      ? const Text('No image selected.')
                      : value.isTranslating
                          ? const AppLoader()
                          : CustomPaint(
                              size: Size(MediaQuery.sizeOf(context).width,
                                  MediaQuery.sizeOf(context).height),
                              painter: ImageTextPainter(
                                  _image!, _textBlocks, _translations, context),
                            ),
                ),
              ),
              Positioned(
                top: 0,
                child: SizedBox(
                    width: kAppsize(context).width,
                    child: HorizontalPadding(
                      child: VerticalPadding(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kBackgroundColor),
                                    child: const AppbackButton()),
                                Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kBackgroundColor),
                                    child: const SettingsButton())
                              ],
                            ),
                            VerticalPadding(
                              padding: 40.h,
                              child: const SwapWidget(),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: verticalPadding,
                        horizontal: horizontalPadding),
                    width: kAppsize(context).width,
                    height: kAppsize(context).height * 0.25,
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(bigBorderRadius),
                          topRight: Radius.circular(bigBorderRadius),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalPadding(child: Text('Translated text')),
                          VerticalPadding(
                            child: HorizontalPadding(
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                direction: Axis.horizontal,
                                spacing: horizontalPadding,
                                children: [
                                  SizedBox(
                                    width: kAppsize(context).width * 0.4,
                                    child: MainActionButton(
                                      language: _isCopied ? "Copied!" : "Copy",
                                      onPressed: () {
                                        _copyToClipboard(
                                            _translations.join(' '));
                                      },
                                      iconWidget: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            _isCopied ? sCopy : sCopy1,
                                            height: 30.h,
                                          ),
                                          SvgPicture.asset(sCopy)
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: kAppsize(context).width * 0.4,
                                    child: MainActionButton(
                                      language: value.isPlayingAudio
                                          ? "Playing..."
                                          : "Play Voice",
                                      onPressed: () {
                                        value.playTranslatedText();
                                      },
                                      iconWidget: SvgPicture.asset(
                                        value.isPlayingAudio ? sPause : sMic,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: kAppsize(context).width * 0.4,
                                    child: MainActionButton(
                                      language: "New",
                                      onPressed: () {
                                        _pickImage(value);
                                      },
                                      iconWidget: SvgPicture.asset(
                                        sCamera,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: kAppsize(context).width * 0.4,
                                    child: MainActionButton(
                                      language: "Translate Again!",
                                      onPressed: () async {
                                        await translateBlocksOfImage(value);
                                      },
                                      iconWidget: SvgPicture.asset(sMore),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  Future<void> _pickImage(RecordingViewModel value) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final inputImage = InputImage.fromFilePath(pickedImage.path);
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(inputImage);
      final uiImage = await loadImage(File(pickedImage.path));

      _image = uiImage;
      _textBlocks = recognizedText.blocks;

      await translateBlocksOfImage(value);

      await textRecognizer.close();

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

  void _copyToClipboard(String text) async {
    // Copy text to clipboard
    await Clipboard.setData(ClipboardData(text: text));

    // Update the state to show "Copied!"
    setState(() {
      _isCopied = true;
    });

    // Revert back to "Copy" after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCopied = false;
        });
      }
    });
  }
}
