import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimon/gaimon.dart';

class TranslatorPrimaryButton extends StatelessWidget {
  const TranslatorPrimaryButton(
      {super.key,
      required this.title,
      this.icon,
      this.size,
      this.fullWidth = true,
      this.onPressed,
      this.btnColor,
      this.textStyle,
      this.opacity = 1});
  final String title;
  final IconData? icon;
  final Color? btnColor;
  final void Function()? onPressed;
  final TextStyle? textStyle;

  final double? size;
  final bool? fullWidth;
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onPressed == null
            ? null
            : () {
                Gaimon.selection();
                onPressed!();
              },
        padding: EdgeInsets.zero,
        child: Opacity(
          opacity: opacity!,
          child: Container(
            width: size ?? kAppsize(context).width * 0.65,
            height: buttonHeight,
            decoration: BoxDecoration(
              gradient: kPrimaryGradient,
              borderRadius: BorderRadius.circular(bigBorderRadius),
            ),
            child: Center(
              child: Text(
                title,
                style: textStyle ?? context.bodySmall.onBackground.bold,
              ),
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
    this.opacity = 1,
    this.bgColor,
  });
  final void Function()? onPressed;
  final IconData? icon;
  final Color? iconColor, bgColor;
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      key: key,
      onPressed: onPressed == null
          ? null
          : () {
              Gaimon.selection();
              onPressed!();
            },
      child: Opacity(
        opacity: opacity!,
        child: Container(
          width: 35.h,
          height: 35.h,
          decoration: BoxDecoration(
            color: bgColor,
            gradient: bgColor == null ? kPrimaryGradient : null,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon ?? CupertinoIcons.arrow_right,
            size: 15.sp,
            color: iconColor ?? context.onBackground,
          ),
        ),
      ),
    );
  }
}

class IconBackgroundWidget extends StatelessWidget {
  const IconBackgroundWidget(
      {super.key,
      this.icon,
      this.iconColor,
      this.backgroundColor,
      this.svgIcon,
      this.height,
      this.width,
      this.child,
      this.hasGradient = false});
  final IconData? icon;
  final Color? backgroundColor, iconColor;
  final bool? hasGradient;
  final String? svgIcon;
  final double? height, width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    assert(svgIcon != null || icon != null || child != null);
    assert(hasGradient! || backgroundColor == null);
    Color? bg = kSecondaryFade1.withOpacity(0.15);
    if (hasGradient!) {
      bg = null;
    }
    return Container(
      width: width ?? 30.h,
      height: height ?? 30.h,
      decoration: BoxDecoration(
        color: backgroundColor ?? bg,
        gradient: hasGradient! ? kPrimaryGradient : null,
        shape: BoxShape.circle,
      ),
      child: child ??
          (svgIcon == null
              ? Icon(
                  icon ?? CupertinoIcons.arrow_right,
                  size: 15.sp,
                  color: iconColor ?? context.onBackground,
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    svgIcon!,
                    height: 16.h,
                  ),
                )),
    );
  }
}
