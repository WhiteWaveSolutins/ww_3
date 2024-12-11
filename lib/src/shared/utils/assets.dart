const String localSvgPath = 'assets/svgs/';
const String localPngPath = 'assets/images/';
const String remoteAssetsPath = '';

//svgs
final String sBackButton = 'back_btn'.svg;
final String sCamera = 'camera'.svg;
final String sFrance = 'france'.svg;
final String sMain = 'main'.svg;
final String sMicBig = 'mic_big'.svg;
final String sMic = 'mic'.svg;
final String sOnboardingAll = 'onboarding-all'.svg;
final String sOnboarding1 = 'onboarding1'.svg;
final String sOnboarding1_1 = 'onboarding11'.svg;
final String sOnboarding2_1 = 'onboarding2-1'.svg;
final String sOnboarding2_1_1 = 'onboarding2-1-1'.svg;
final String sOnboarding2_2 = 'onboarding2-2'.svg;
final String sOnboarding2_3 = 'onboarding2_3'.svg;
final String sOnboarding3 = 'onboarding3'.svg;
final String sOnboarding4 = 'onboarding4'.svg;
final String sOnboarding2_1a = 'onboaring2-1a'.svg;
final String sPause = 'pause'.svg;
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

extension ImageExtension on String {
  // png paths
  String get png => '$localPngPath$this.png';
  // svgs path
  String get svg => '$localSvgPath$this.svg';
}
