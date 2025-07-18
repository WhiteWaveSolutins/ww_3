import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:provider/provider.dart';

import '../../../../service-locators/app.dart';
import '../../../../shared/utils/assets.dart';
import '../../../../shared/utils/size_utils.dart';
import '../../../../shared/utils/theme.dart';
import '../../../../shared/widgets/buttons.dart';
import '../../../../shared/widgets/loaders.dart';
import '../../../../shared/widgets/scaffold.dart';
import '../../../../shared/widgets/textfields.dart';
import '../../../main/presentation/ui/widgets/widgets.dart';
import '../../../settings/ui/settings.dart';
import '../../logic/viewmodel.dart';

class CameraView extends StatefulWidget {
  const CameraView(
      {super.key,
      required this.customPaint,
      required this.onImage,
      this.onCameraFeedReady,
      this.onDetectorViewModeChanged,
      this.onCameraLensDirectionChanged,
      this.initialCameraLensDirection = CameraLensDirection.back,
      required this.translations});

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final VoidCallback? onCameraFeedReady;
  final VoidCallback? onDetectorViewModeChanged;
  final List<String> translations;
  final Function(CameraLensDirection direction)? onCameraLensDirectionChanged;
  final CameraLensDirection initialCameraLensDirection;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  static List<CameraDescription> _cameras = [];
  CameraController? _controller;
  int _cameraIndex = -1;
  double currentZoomLevel = 1.0;
  double minAvailableZoom = 1.0;
  double maxAvailableZoom = 1.0;
  double minAvailableExposureOffset = 0.0;
  double maxAvailableExposureOffset = 0.0;
  double currentExposureOffset = 0.0;
  bool _changingCameraLens = false;
  bool _isCopied = false;

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  void _initialize() async {
    if (_cameras.isEmpty) {
      _cameras = await availableCameras();
    }
    for (var i = 0; i < _cameras.length; i++) {
      if (_cameras[i].lensDirection == widget.initialCameraLensDirection) {
        _cameraIndex = i;
        break;
      }
    }
    if (_cameraIndex != -1) {
      log('Live Feed Started');
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _liveFeedBody();
  }

  Widget _liveFeedBody() {
    if (_cameras.isEmpty) return Container();
    if (_controller == null) return Container();
    if (_controller?.value.isInitialized == false) return Container();
    return AppBackground(
      imageBg: sMainBg,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: _changingCameraLens
                ? const Center(
                    child: Text('Changing camera lens'),
                  )
                : Padding(
                    padding: EdgeInsets.only(top: bigPadding),
                    child: CameraPreview(
                      _controller!,
                      child: widget.customPaint,
                    ),
                  ),
          ),
          _backButton(),
          _bottomWidget(),
          if (serviceLocator<RecordingViewModel>().isTranslating)
            const AppLoader()
        ],
      ),
    );
  }

  Widget _backButton() => Positioned(
      top: 40,
      left: horizontalPadding,
      right: horizontalPadding,
      child: SizedBox(
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
      ));

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
                                    _copyToClipboard(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppFabButton(
                              key: const Key('gallery'),
                              onPressed: () {
                                value.resetTranslation();
                                widget.onDetectorViewModeChanged!();
                              },
                              icon: CupertinoIcons.photo_fill_on_rectangle_fill,
                            ),
                            AppFabButton(
                                key: const Key('camera'),
                                onPressed: () {
                                  value.resetTranslation();
                                  _switchLiveCamera();
                                },
                                icon: CupertinoIcons.switch_camera),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));

  Future _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      // Set to ResolutionPreset.high. Do NOT set it to ResolutionPreset.max because for some phones does NOT work.
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.getMinZoomLevel().then((value) {
        currentZoomLevel = value;
        minAvailableZoom = value;
      });
      _controller?.getMaxZoomLevel().then((value) {
        maxAvailableZoom = value;
      });
      currentExposureOffset = 0.0;
      _controller?.getMinExposureOffset().then((value) {
        minAvailableExposureOffset = value;
      });
      _controller?.getMaxExposureOffset().then((value) {
        maxAvailableExposureOffset = value;
      });
      _controller?.startImageStream(_processCameraImage).then((value) {
        if (widget.onCameraFeedReady != null) {
          widget.onCameraFeedReady!();
        }
        if (widget.onCameraLensDirectionChanged != null) {
          widget.onCameraLensDirectionChanged!(camera.lensDirection);
        }
      });
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _switchLiveCamera() async {
    setState(() => _changingCameraLens = true);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;

    await _stopLiveFeed();
    await _startLiveFeed();
    setState(() => _changingCameraLens = false);
  }

  void _processCameraImage(CameraImage image) {
    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;
    widget.onImage(inputImage);
  }

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_controller == null) return null;
    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
          _orientations[_controller!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
      // print('rotationCompensation: $rotationCompensation');
    }
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) {
      return null;
    }

    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  void _copyToClipboard(String text) async {
    // Copy text to clipboard
    await Clipboard.setData(ClipboardData(text: text));

    // Update the state to show "Copied!"
    setState(() {
      _isCopied = true;
    });

    // Revert back to "Copy" after 2 seconds
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          setState(() {
            _isCopied = false;
          });
        }
      },
    );
  }
}
