import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormLabelWidget extends StatelessWidget {
  const FormLabelWidget({
    super.key,
    required this.label,
    required this.textfield,
    this.bottomPadding,
  });
  final String label;
  final Widget textfield;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding ?? verticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.bodySmall.primary.bold),
          VerticalPadding(
            isSmallPadding: true,
            child: textfield,
          ),
        ],
      ),
    );
  }
}

class HorizontalPadding extends StatelessWidget {
  const HorizontalPadding(
      {super.key,
      this.isSmallPadding = false,
      this.padding,
      required this.child});
  final bool? isSmallPadding;
  final double? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding ??
            (isSmallPadding! ? smallHorizontalPadding : horizontalPadding),
      ),
      child: child,
    );
  }
}

class VerticalPadding extends StatelessWidget {
  const VerticalPadding(
      {super.key,
      this.isSmallPadding = false,
      this.padding,
      required this.child});
  final bool? isSmallPadding;
  final double? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: padding ??
              (isSmallPadding! ? smallVerticalPadding : verticalPadding)),
      child: child,
    );
  }
}

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({
    super.key,
    this.space,
  });

  final double? space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space ?? verticalPadding);
  }
}

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer({
    super.key,
    this.space,
  });

  final double? space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space ?? horizontalPadding);
  }
}

class TranslatorTextFieldWidget extends StatelessWidget {
  const TranslatorTextFieldWidget({
    super.key,
    this.hintText,
    this.label,
    this.obscureText = false,
    this.textInputType,
    this.validator,
    this.controller,
    this.textInputAction,
    this.inputFormatters,
    this.textAlign,
    this.onChanged,
    this.initialValue,
    this.suffixIcon = const SizedBox.shrink(),
    this.readOnly = false,
    this.enabled,
    this.autovalidateMode,
    this.prefixIcon,
    this.text = '',
    this.validated = false,
    this.hintStyle,
    this.textStyle,
    this.showConfirmation = false,
    this.onTap,
    this.maxLines = 1,
  });

  final String? hintText;
  final String? label, initialValue, text;
  final bool? obscureText, showConfirmation;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? suffixIcon, prefixIcon;
  final bool? readOnly, enabled, validated;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? hintStyle, textStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextFormFieldRow(
      style: textStyle ?? context.bodyLarge,
      inputFormatters: inputFormatters,
      textAlign: textAlign ?? TextAlign.start,
      validator: validator,
      initialValue: initialValue,
      keyboardType: textInputType,
      obscureText: obscureText!,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly!,
      maxLines: maxLines!,
      enabled: enabled,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      textInputAction: textInputAction,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      autofillHints: ['$hintText'],
      prefix: prefixIcon,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(textFieldBorderRadius),
        border: Border.all(),
      ),
    );
  }
}
