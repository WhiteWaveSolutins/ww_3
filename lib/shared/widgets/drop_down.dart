import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/theme.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.color,
  });
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? context.onSurface.withOpacity(0.2),
      thickness: 0.3,
    );
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
