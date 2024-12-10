import 'package:ai_translator/src/features/main/ui/main.dart';
import 'package:ai_translator/src/features/settings/ui/settings.dart';
import 'package:ai_translator/src/shared/utils/assets.dart';
import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  static const routeName = '/camera';

  @override
  State<CameraScreen> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<CameraScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          sPlaceholderPng,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 0,
          child: SizedBox(
              width: kAppsize(context).width,
              child: HorizontalPadding(
                child: VerticalPadding(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: kBackgroundColor),
                          child: const AppbackButton()),
                      Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: kBackgroundColor),
                          child: const SettingsButton())
                    ],
                  ),
                ),
              )),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: verticalPadding, horizontal: horizontalPadding),
              width: kAppsize(context).width,
              height: kAppsize(context).height * 0.2,
              decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(bigBorderRadius),
                    topRight: Radius.circular(bigBorderRadius),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Translated text'),
                  VerticalPadding(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MainActionButton(
                          language: "     Copy      ",
                          onPressed: () {
                            // Navigator.restorablePushNamed(
                            //     context, RecordingScreen.routeName);
                          },
                          iconWidget: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                sCopy1,
                                height: 30.h,
                              ),
                              SvgPicture.asset(sCopy)
                            ],
                          ),
                        ),
                        MainActionButton(
                          language: "Play Voice",
                          onPressed: () {
                            // Navigator.restorablePushNamed(
                            //     context, CameraScreen.routeName);
                          },
                          icon: sMic,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    ));
  }
}
