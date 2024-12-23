const String localSvgPath = 'assets/svgs/';
const String localPngPath = 'assets/images/';
const String remoteAssetsPath = '';

//svgs
final String sBackButton = 'back_btn'.svg;

final String sFrance = 'france'.svg;

final String sMicBig = 'mic_big'.svg;
final String sMic = 'mic'.svg;
final String sOnboardingAll = 'onboarding-all'.svg;

final String sPause = 'pause'.svg;
final String sSettings = 'settings'.svg;
final String sPay = 'pay'.svg;
final String sPlay = 'play'.svg;
final String sSwap = 'swap'.svg;
final String sUsa = 'usa'.svg;
final String sArrowRight = 'arrow_right'.svg;
final String sMore = 'more'.svg;
final String sCopy = 'copy'.svg;
final String sCopy1 = 'ellipse_copy'.svg;
final String sRecordBackground = 'record_background'.svg;

//pngs
final String sLogoPng = 'logo'.png;
final String sFlutterLogoPng = 'flutter_logo'.png;
final String sPlaceholderPng = 'placeholder'.png;
final String sSplash = 'splash'.png;
final String sOnboarding1 = 'onboarding-1'.png;
final String sOnboarding2 = 'onboarding-2'.png;
final String sOnboarding3 = 'onboarding-3'.png;
final String sOnboarding4 = 'onboarding-4'.png;
final String sMainBg = 'main_bg'.png;
final String sMain = 'main'.svg;
final String sCamera = 'camera'.png;

extension ImageExtension on String {
  // png paths
  String get png => '$localPngPath$this.png';
  // svgs path
  String get svg => '$localSvgPath$this.svg';
}
