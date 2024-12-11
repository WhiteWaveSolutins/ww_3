import 'package:ai_translator/src/shared/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';

String? _fontFamily = GoogleFonts.poppins().fontFamily;

CupertinoThemeData translatorLightTheme = CupertinoThemeData(
  applyThemeToAll: true,
  barBackgroundColor: kBackgroundColor,
  brightness: Brightness.light,
  primaryColor: kPrimaryColor1,
  primaryContrastingColor: kPrimaryColor2,
  scaffoldBackgroundColor: kBackgroundColor,
  textTheme: const CupertinoTextThemeData().copyWith(
    primaryColor: kTextColor,
    textStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: textSize,
    ),
    actionTextStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: smallTextSize,
    ),
    tabLabelTextStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: textSize,
    ),
    navActionTextStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: textSize,
    ),
    navLargeTitleTextStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: largeTextSize,
    ),
    navTitleTextStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: mediumTextSize,
    ),
    pickerTextStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: textSize,
    ),
    dateTimePickerTextStyle: TextStyle(
      fontFamily: _fontFamily,
      color: kTextColor,
      fontSize: textSize,
    ),
  ),
);

const kPrimaryColor1 = Color(0xffDDFC53);
const kPrimaryColor2 = Color(0xff7FDF76);

final kBottomSheetColor = const Color(0xff39397B).withOpacity(0.9);

const kPrimaryGradient = LinearGradient(colors: [
  kPrimaryColor2,
  kPrimaryColor1,
]);

const kBackgroundColor = Color(0xff1B1B26);

const kSurfaceColor = Color(0xffFFFFFF);

const kTabFade1 = Color(0xffF9FFFF);
const kTabFade2 = Color(0xffECF8FB);
const kTabFade3 = Color(0xffE7EAFB);
const kTabFade4 = Color(0xffF5F6FE);

const kTabFadedGradient =
    LinearGradient(colors: [kTabFade1, kTabFade2, kTabFade3, kTabFade4]);

const kSecondaryFade1 = Color(0xffFAFEFE);
const kSecondaryFade2 = Color(0xffE3F5F8);
const kSecondaryFade3 = Color(0xffF0F2FD);
const kSecondaryFade4 = Color(0xff000033);

const kSecondaryGradient = LinearGradient(colors: [
  kSecondaryFade1,
  kSecondaryFade4,
  kSecondaryFade4,
  kSecondaryFade1,
]);

const kRed = Color(0xffFF1818);

const kBlue = Color(0xff6EB1FE);

const kTextColor = Color(0xffFFFFFF);
const kTextColorDarkMode = Color(0xff000000);

CupertinoThemeData translatorDarkTheme = CupertinoThemeData(
  applyThemeToAll: true,
  barBackgroundColor: kBackgroundColor,
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor1,
  primaryContrastingColor: kPrimaryColor2,
  scaffoldBackgroundColor: kBackgroundColor,
  textTheme: const CupertinoTextThemeData().copyWith(
    textStyle: TextStyle(fontFamily: _fontFamily),
    actionTextStyle: TextStyle(fontFamily: _fontFamily),
    tabLabelTextStyle: TextStyle(fontFamily: _fontFamily),
    navActionTextStyle: TextStyle(fontFamily: _fontFamily),
    navLargeTitleTextStyle: TextStyle(fontFamily: _fontFamily),
    navTitleTextStyle: TextStyle(fontFamily: _fontFamily),
    pickerTextStyle: TextStyle(fontFamily: _fontFamily),
    dateTimePickerTextStyle: TextStyle(fontFamily: _fontFamily),
  ),
);

extension FastColor on BuildContext {
  Color get primary => kPrimaryColor1;

  Color get secondary => kPrimaryColor2;

  Color get tertiary => CupertinoColors.activeBlue;

  Color get primaryContainer => kBackgroundColor;

  Color get secondaryContainer => CupertinoColors.activeBlue;

  Color get tertiaryContainer => CupertinoColors.activeBlue;

  Color get onPrimary => CupertinoColors.activeBlue;

  Color get onSecondary => CupertinoColors.activeBlue;

  Color get onTertiary => CupertinoColors.activeBlue;

  Color get background => CupertinoColors.activeBlue;

  Color get onBackground => kTextColorDarkMode;

  Color get surface => CupertinoColors.activeBlue;

  Color get onSurface => kSecondaryFade1;

  Color get surfaceTint => CupertinoColors.activeBlue;

  Color get error => CupertinoColors.activeBlue;

  Color get onError => CupertinoColors.activeBlue;

  Color get outline => CupertinoColors.activeBlue;

  Color get inversePrimary => CupertinoColors.activeBlue;

  Color get inverseSurface => CupertinoColors.activeBlue;

  Color get onInverseSurface => CupertinoColors.activeBlue;
}
