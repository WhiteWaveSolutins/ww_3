import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets.dart';
import '../utils/text_theme.dart';
import '../utils/theme.dart';
import 'loaders.dart';
import 'textfields.dart';

class TranslatorScaffold extends StatefulWidget {
  const TranslatorScaffold({
    super.key,
    required this.body,
    this.backgroundColor,
    this.isLoading = false,
    this.appBar,
    this.floatingActionButton,
    this.isUnavailableFeatureScreen = false,
    this.bottomsheet,
    this.bottomAppBar,
    this.drawer,
  });

  final Widget body;
  final Color? backgroundColor;
  final bool isLoading;
  final ObstructingPreferredSizeWidget? appBar;
  final Widget? bottomsheet, drawer;
  final Widget? floatingActionButton, bottomAppBar;
  final bool isUnavailableFeatureScreen;

  @override
  State<TranslatorScaffold> createState() => _TranslatorScaffoldState();
}

class _TranslatorScaffoldState extends State<TranslatorScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: CupertinoPageScaffold(
        backgroundColor: widget.backgroundColor ?? kBackgroundColor,
        navigationBar: widget.appBar,
        resizeToAvoidBottomInset: false,
        child: Stack(
          children: [
            SafeArea(child: widget.body),
            if (widget.isLoading) const AppLoader(),
          ],
        ),
      ),
    );
  }
}

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.imageBg,
  });
  final Widget child;
  final String? imageBg;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageBg ?? sSplash),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

class SplashActions extends StatelessWidget {
  const SplashActions({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Text(
        text,
        style: context.bodySmall,
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return HorizontalPadding(
      child: Row(
        mainAxisAlignment: mainAxisAlignment!,
        children: [SvgPicture.asset(sMic), const Text(' Voice Translate')],
      ),
    );
  }
}
