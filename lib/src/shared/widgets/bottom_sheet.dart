import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/buttons.dart';
import 'package:ai_translator/src/shared/widgets/scaffold.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';

Future<dynamic> showAppBottomSheet(BuildContext context,
    {double? height,
    hPadding,
    vPadding,
    required Widget child,
    required String title,
    bool? isLoading = false,
    bool? isDismissible = false,
    Widget? bottomWidget,
    void Function()? onButtonPressed,
    void Function()? onSheetClosed,
    String? bottomText}) {
  return showCupertinoModalPopup(
    barrierDismissible: isDismissible!,
    context: context,
    builder: (context) {
      return Container(
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bigBorderRadius),
                topRight: Radius.circular(bigBorderRadius)),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: hPadding ?? horizontalPadding,
              vertical: vPadding ?? verticalPadding),
          height: height ?? MediaQuery.sizeOf(context).height * 0.9,
          child: BottomSheetChild(
              isDismissible: isDismissible,
              onSheetClosed: onSheetClosed,
              bottomText: bottomText,
              bottomWidget: bottomWidget,
              isLoading: isLoading,
              onButtonPressed: onButtonPressed,
              title: title,
              child: child));
    },
  );
}

class BottomSheetChild extends StatelessWidget {
  const BottomSheetChild({
    super.key,
    required this.isDismissible,
    this.bottomWidget,
    required this.onSheetClosed,
    this.bottomText,
    this.isLoading,
    this.onButtonPressed,
    required this.child,
    required this.title,
  });
  final bool? isLoading, isDismissible;
  final Widget? bottomWidget;
  final Widget child;
  final void Function()? onButtonPressed, onSheetClosed;
  final String? bottomText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TranslatorScaffold(
      isLoading: isLoading!,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VerticalSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.headlineSmall.bold,
                ),
                CupertinoButton(
                    onPressed: onSheetClosed ??
                        () {
                          Navigator.pop(context);
                        },
                    child: const Icon(CupertinoIcons.clear))
              ],
            ),
            VerticalSpacer(
              space: 30.h,
            ),
            child,
          ],
        ),
      ),
      bottomAppBar: Container(
        color: context.background,
        child: bottomWidget ??
            TranslatorPrimaryButton(
              title: bottomText ?? 'Add',
              onPressed: onButtonPressed,
            ),
      ),
    );
  }
}
