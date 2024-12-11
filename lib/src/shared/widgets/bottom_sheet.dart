import 'dart:ui';

import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showAppBottomSheet(BuildContext context,
    {double? height,
    hPadding,
    vPadding,
    required Widget child,
    bool? isLoading = false,
    bool? isDismissible = false,
    void Function()? onButtonPressed,
    void Function()? onSheetClosed,
    String? bottomText}) {
  return showCupertinoModalPopup(
    barrierDismissible: isDismissible!,
    context: context,
    barrierColor: const Color(0xff39397B).withOpacity(0.1),
    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
    builder: (context) {
      return Container(
          decoration: BoxDecoration(
            color: kBottomSheetColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bigBorderRadius),
                topRight: Radius.circular(bigBorderRadius)),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: hPadding ?? horizontalPadding,
              vertical: vPadding ?? verticalPadding),
          height: height ?? MediaQuery.sizeOf(context).height * 0.8,
          child: BottomSheetChild(
              isDismissible: isDismissible,
              onSheetClosed: onSheetClosed,
              bottomText: bottomText,
              isLoading: isLoading,
              onButtonPressed: onButtonPressed,
              child: child));
    },
  );
}

class BottomSheetChild extends StatelessWidget {
  const BottomSheetChild({
    super.key,
    required this.isDismissible,
    required this.onSheetClosed,
    this.bottomText,
    this.isLoading,
    this.onButtonPressed,
    required this.child,
  });
  final bool? isLoading, isDismissible;

  final Widget child;
  final void Function()? onButtonPressed, onSheetClosed;
  final String? bottomText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
              child: Container(
            height: 5.h,
            width: 150.w,
            decoration: BoxDecoration(
                color: kSecondaryFade1.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2)),
          )),
          Container(
              color: const Color(0xff39397B).withOpacity(0.1), child: child),
        ],
      ),
    );
  }
}
