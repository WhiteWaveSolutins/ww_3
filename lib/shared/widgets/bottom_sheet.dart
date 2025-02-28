import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../utils/size_utils.dart';
import '../utils/theme.dart';

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
          decoration: const BoxDecoration(
            color: kBackgroundColor,
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
              height: 5,
              width: 150,
              decoration: BoxDecoration(
                  color: kSecondaryFade1.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Container(
            color: const Color(0xff39397B).withValues(alpha: .1),
            child: child,
          ),
        ],
      ),
    );
  }
}
