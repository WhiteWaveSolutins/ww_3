import 'package:ai_translator/src/core/observer/navigation_service.dart';
import 'package:ai_translator/src/shared/utils/theme.dart';
import 'package:flutter/cupertino.dart';

extension FastTextStyle on BuildContext {
  CupertinoTextThemeData get textTheme => CupertinoTheme.of(this).textTheme;

  TextStyle get bodySmall => textTheme.actionTextStyle;

  TextStyle get bodyMedium => textTheme.textStyle;

  TextStyle get bodyLarge => textTheme.textStyle.bold;

  TextStyle get labelSmall => textTheme.tabLabelTextStyle;

  TextStyle get labelMedium => textTheme.tabLabelTextStyle;

  TextStyle get labelLarge => textTheme.tabLabelTextStyle.bold;

  TextStyle get titleSmall => textTheme.pickerTextStyle;

  TextStyle get titleMedium => textTheme.dateTimePickerTextStyle;

  TextStyle get titleLarge => textTheme.dateTimePickerTextStyle;

  TextStyle get headlineSmall => textTheme.navActionTextStyle;

  TextStyle get headlineMedium => textTheme.navLargeTitleTextStyle;

  TextStyle get headlineLarge => textTheme.navLargeTitleTextStyle;

  TextStyle get displaySmall => textTheme.navTitleTextStyle;

  TextStyle get displayMedium => textTheme.navTitleTextStyle;

  TextStyle get displayLarge => textTheme.navTitleTextStyle.bold;
}

extension FastTextColor on TextStyle {
  BuildContext get context =>
      TranslatorNavigationService.navigatorKey!.currentContext!;

  TextStyle get primary =>
      copyWith(color: CupertinoTheme.of(context).primaryColor);

  TextStyle get secondary =>
      copyWith(color: CupertinoTheme.of(context).primaryContrastingColor);

  TextStyle get tertiary =>
      copyWith(color: CupertinoTheme.of(context).scaffoldBackgroundColor);

  TextStyle get onPrimary => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get onSecondary => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get onTertiary => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get background =>
      copyWith(color: CupertinoTheme.of(context).scaffoldBackgroundColor);

  TextStyle get onBackground => copyWith(color: kTextColorDarkMode);

  TextStyle get surface => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get onSurface => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get surfaceTint => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get error => copyWith(color: CupertinoColors.systemRed);

  TextStyle get onError => copyWith(color: CupertinoColors.systemOrange);

  TextStyle get outline => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get inversePrimary => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get inverseSurface => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get onInverseSurface => copyWith(color: CupertinoColors.systemGrey);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w900);

  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
}
