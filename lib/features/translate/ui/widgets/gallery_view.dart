import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../service-locators/app.dart';
import '../../../../shared/utils/assets.dart';
import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/utils/text_theme.dart';
import '../../../../shared/utils/theme.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/loaders.dart';
import '../../../../shared/widgets/scaffold.dart';
import '../../../../shared/widgets/textfields.dart';
import '../../../main/presentation/ui/widgets/widgets.dart';
import '../../../settings/ui/settings.dart';
import '../../logic/viewmodel.dart';

class GalleryView extends StatefulWidget {
  const GalleryView(
      {super.key,
      required this.title,
      this.text,
      required this.onImage,
      required this.onDetectorViewModeChanged,
      this.widget,
      required this.translations,
      required this.clearTranslations});

  final String title;
  final String? text;
  final List<String> translations;
  final Function() clearTranslations;
  final Function(InputImage inputImage) onImage;
  final Function()? onDetectorViewModeChanged;
  final Widget? widget;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  String? path;
  ImagePicker? _imagePicker;
  final bool _isCopied = false;
  bool _showImageOnly = false;

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
    return GestureDetector(
      onTap: () {
        setState(() {
          _showImageOnly = !_showImageOnly;
        });
      },
      child: AppBackground(
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: horizontalPadding,
                      top: verticalPadding,
                      right: horizontalPadding),
                  child: _backButton()

                  //     AppFabButton(
                  //   onPressed: widget.onDetectorViewModeChanged,
                  //   icon: CupertinoIcons.camera,
                  // ),
                  ),
            ),
            _image != null
                ? Consumer<RecordingViewModel>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image.file(
                            _image!,
                            fit: BoxFit.contain,
                          ),
                          if (widget.widget != null) widget.widget!,
                          if (value.isTranslating) const AppLoader(),
                          if (value.errorMessage.isNotEmpty)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              color: kBackgroundColor.withValues(alpha: .2),
                              child: Center(
                                  child: Text(
                                value.errorMessage,
                                style: context.displayLarge,
                              )),
                            )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Icon(
                      CupertinoIcons.photo,
                      size: 200,
                    ),
                  ),
            if (!_showImageOnly) _bottomWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backButton() => SizedBox(
        width: kAppSize(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBackButton(
              onPressed: () {
                serviceLocator<RecordingViewModel>().resetTranslation();
                Navigator.pop(context);
              },
            ),
            const SettingsButton(),
          ],
        ),
      );

  Widget _bottomWidget() => Positioned(
      bottom: 0,
      child: Consumer<RecordingViewModel>(
        builder: (context, value, child) => Container(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          width: kAppSize(context).width,
          height: kAppSize(context).height *
              ((widget.translations.isNotEmpty) ? 0.25 : 0.2),
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
                    child: Text(
                        (widget.translations.isEmpty || value.isTranslating)
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
                                  width: 130,
                                  language: _isCopied ? "Copied!" : "Copy",
                                  onPressed: () {
                                    value.copyToClipboard(
                                        widget.translations.join(' '));
                                  },
                                  iconWidget: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        _isCopied ? sCopy : sCopy1,
                                        height: 30,
                                      ),
                                      SvgPicture.asset(sCopy)
                                    ],
                                  ),
                                ),
                                if (widget.translations.isNotEmpty)
                                  MainActionButton(
                                    width: 130,
                                    language: value.isPlayingAudio
                                        ? "Playing..."
                                        : "Play Voice",
                                    onPressed: value.isPlayingAudio
                                        ? null
                                        : () {
                                            value.playTranslatedText(
                                                textAndSound: value
                                                    .translatedTextAndSpeech);
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
                                onPressed: () {
                                  widget.clearTranslations();

                                  value.resetTranslation();

                                  _getImage(ImageSource.gallery);
                                }),
                            CupertinoButton(
                                child: const Text('Take a picture'),
                                onPressed: () {
                                  widget.clearTranslations();

                                  value.resetTranslation();
                                  _getImage(ImageSource.camera);
                                }),
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
}
