import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:flutter/cupertino.dart';

class TranslatorPrimaryButton extends StatelessWidget {
  const TranslatorPrimaryButton(
      {super.key,
      required this.title,
      this.icon,
      this.size,
      this.fullWidth = true,
      this.onPressed,
      this.btnColor,
      this.textStyle});
  final String title;
  final IconData? icon;
  final Color? btnColor;
  final void Function()? onPressed;
  final TextStyle? textStyle;

  ///must be gf sizes
  final double? size;
  final bool? fullWidth;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Container(
          width: size ?? kAppsize(context).width * 0.7,
          height: buttonHeight,
          decoration: BoxDecoration(
            gradient: kPrimaryGradient,
            borderRadius: BorderRadius.circular(bigBorderRadius),
          ),
          child: Center(
            child: Text(
              title,
              style: textStyle ?? context.bodyMedium.onBackground,
            ),
          ),
        ));
  }
}

class AppFabButton extends StatelessWidget {
  const AppFabButton({
    super.key,
    this.onPressed,
    this.icon,
    this.iconColor,
  });
  final void Function()? onPressed;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: buttonHeight,
        height: buttonHeight,
        decoration: const BoxDecoration(
          gradient: kPrimaryGradient,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon ?? CupertinoIcons.arrow_right,
          color: iconColor ?? context.onBackground,
        ),
      ),
    );
  }
}
