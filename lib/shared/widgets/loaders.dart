import 'package:flutter/material.dart';

import '../utils/theme.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.isSmall = false,
  });
  final bool? isSmall;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: !isSmall! ? 80 : 30,
        width: !isSmall! ? 80 : 30,
        decoration: BoxDecoration(
          color: context.primary.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const CircularProgressIndicator(
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
