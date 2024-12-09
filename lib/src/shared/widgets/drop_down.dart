import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:ai_translator/src/shared/utils/text_theme.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:ai_translator/src/shared/widgets/textfields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalPadding(
        child: Divider(
      color: context.outline.withOpacity(0.2),
    ));
  }
}

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        value: value, activeColor: context.primary, onChanged: onChanged);
  }
}

class AppDropdownField extends StatefulWidget {
  final String hintText;
  final List<String> values;
  final Function(String?) onChanged;
  final String? selectedValue;
  final bool? isExpanded;
  final double? height;

  const AppDropdownField({
    super.key,
    required this.hintText,
    required this.values,
    required this.onChanged,
    this.selectedValue,
    this.isExpanded = true,
    this.height,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  bool _isFocused = false;
  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        height: widget.height ?? 40.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: _isFocused ? context.primary : context.outline,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: DropdownButton<String>(
              hint: Text(
                widget.hintText,
                style: context.bodySmall,
              ),
              value: widget.selectedValue,
              icon: Icon(Icons.keyboard_arrow_down,
                  color: _isFocused ? context.primary : context.outline),
              isExpanded: widget.isExpanded!,
              items: widget.values.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: context.bodyLarge,
                  ),
                );
              }).toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
