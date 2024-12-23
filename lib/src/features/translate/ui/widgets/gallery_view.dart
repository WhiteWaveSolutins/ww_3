import 'dart:io';

import 'package:ai_translator/src/features/main/presentation/ui/widgets/widgets.dart';
import 'package:ai_translator/src/features/translate/logic/viewmodel.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/loaders.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GalleryView extends StatefulWidget {
  const GalleryView(
      {super.key,
      required this.title,
      this.text,
      required this.onImage,
      required this.onDetectorViewModeChanged,
      this.customPaint,
      required this.translations});

  final String title;
  final String? text;
  final List<String> translations;
  final Function(InputImage inputImage) onImage;
  final Function()? onDetectorViewModeChanged;
  final CustomPaint? customPaint;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  String? path;
  ImagePicker? _imagePicker;
  bool _isCopied = false;

  @override
  void initState() {
    super.initState();

    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: _galleryBody());
  }

  Widget _galleryBody() {
    return AppBackground(
      child: Stack(
        children: [
          SafeArea(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: horizontalPadding, top: verticalPadding),
                  child: AppFabButton(
                    onPressed: widget.onDetectorViewModeChanged,
                    icon: CupertinoIcons.camera,
                  ),
                ),
              ],
            ),
          ),
          _image != null
              ? Consumer<RecordingViewModel>(
                  builder: (context, value, child) => Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Image.file(
                          _image!,
                          fit: BoxFit.fitWidth,
                        ),
                        if (widget.customPaint != null) widget.customPaint!,
                        if (value.isTranslating) const AppLoader()
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Icon(
                    CupertinoIcons.photo,
                    size: 200.h,
                  ),
                ),
          _bottomWidget()
        ],
      ),
    );
  }

  Widget _bottomWidget() => Positioned(
      bottom: 0,
      child: Consumer<RecordingViewModel>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
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
                VerticalPadding(
                    child: Text(value.isTranslating
                        ? 'Translating.....'
                        : 'Translated text')),
                VerticalPadding(
                  child: HorizontalPadding(
                    child: Column(
                      children: [
                        if (widget.translations.isNotEmpty)
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: smallVerticalPadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MainActionButton(
                                  width: 130.w,
                                  language: _isCopied ? "Copied!" : "Copy",
                                  onPressed: () {
                                    _copyToClipboard(
                                        widget.translations.join(' '));
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
                                if (widget.translations.isNotEmpty)
                                  MainActionButton(
                                    width: 130.w,
                                    language: value.isPlayingAudio
                                        ? "Playing..."
                                        : "Play Voice",
                                    onPressed: value.isPlayingAudio
                                        ? null
                                        : () {
                                            value.playTranslatedText();
                                          },
                                    iconWidget:
                                        IconBackgroundWidget(svgIcon: sMic),
                                  ),
                              ],
                            ),
                          ),
                        Row(
                          children: [
                            CupertinoButton(
                              child: const Text('From Gallery'),
                              onPressed: () => _getImage(ImageSource.gallery),
                            ),
                            CupertinoButton(
                              child: const Text('Take a picture'),
                              onPressed: () => _getImage(ImageSource.camera),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
      path = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      await _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    path = path;
    final inputImage = InputImage.fromFilePath(path);
    await widget.onImage(inputImage);
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
