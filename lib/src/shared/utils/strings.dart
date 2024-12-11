//

const kInternetConnectionError = 'No internet connection, try again.';
const kTimeOutError = 'Please check your internet conenction.';
const kServerError = 'Something went wrong, try again.';
const kFormatError = 'Unable to process data at this time.';
const kUnAuthorizedError = 'Session expired, please login to proceed.';
const kDefaultError = 'Oops something went wrong!';
const kBadRequestError = 'Bad request, please try again.';
const kNotFoundError = 'An error occured, please try again.';
const kRequestCancelledError = 'Request to server was cancelled.';

const String ruble = '₽';

const String kBaseUrl = '';
const String kApiVersion = 'v1';

const privacyPolicyText =
    '''The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
- Obscene, crude, or violent posts
- False or misleading content
- Breaking the law
- Spamming or scamming the service or other users
- Hacking or tampering with your website or app
- Violating copyright laws
- Harassing other users
- Stalking other users

If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
- Obscene, crude, or violent posts
- False or misleading content
- Breaking the law
- Spamming or scamming the service or other users
- Hacking or tampering with your website or app
- Violating copyright laws
- Harassing other users
- Stalking other users

If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.

The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
Here is where you can list and ban behaviors and activities like:
- Obscene, crude, or violent posts
- False or misleading content
- Breaking the law
- Spamming or scamming the service or other users
- Hacking or tampering with your website or app
- Violating copyright laws
- Harassing other users
- Stalking other users

If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use. ''';

final supportedLanguages = [
  {'name': 'Afrikaans', 'code': 'af', 'flag': '🇿🇦'},
  {'name': 'Albanian', 'code': 'sq', 'flag': '🇦🇱'},
  {'name': 'Arabic', 'code': 'ar', 'flag': '🇸🇦'},
  {'name': 'Armenian', 'code': 'hy', 'flag': '🇦🇲'},
  {'name': 'Bengali', 'code': 'bn', 'flag': '🇧🇩'},
  {'name': 'Bulgarian', 'code': 'bg', 'flag': '🇧🇬'},
  {'name': 'Catalan', 'code': 'ca', 'flag': '🇪🇸'},
  {'name': 'Chinese (Simplified)', 'code': 'zh', 'flag': '🇨🇳'},
  {'name': 'Chinese (Traditional)', 'code': 'zh-TW', 'flag': '🇹🇼'},
  {'name': 'Croatian', 'code': 'hr', 'flag': '🇭🇷'},
  {'name': 'Czech', 'code': 'cs', 'flag': '🇨🇿'},
  {'name': 'Danish', 'code': 'da', 'flag': '🇩🇰'},
  {'name': 'Dutch', 'code': 'nl', 'flag': '🇳🇱'},
  {'name': 'English', 'code': 'en', 'flag': '🇬🇧'},
  {'name': 'Estonian', 'code': 'et', 'flag': '🇪🇪'},
  {'name': 'Filipino', 'code': 'tl', 'flag': '🇵🇭'},
  {'name': 'Finnish', 'code': 'fi', 'flag': '🇫🇮'},
  {'name': 'French', 'code': 'fr', 'flag': '🇫🇷'},
  {'name': 'Georgian', 'code': 'ka', 'flag': '🇬🇪'},
  {'name': 'German', 'code': 'de', 'flag': '🇩🇪'},
  {'name': 'Greek', 'code': 'el', 'flag': '🇬🇷'},
  {'name': 'Gujarati', 'code': 'gu', 'flag': '🇮🇳'},
  {'name': 'Hebrew', 'code': 'he', 'flag': '🇮🇱'},
  {'name': 'Hindi', 'code': 'hi', 'flag': '🇮🇳'},
  {'name': 'Hungarian', 'code': 'hu', 'flag': '🇭🇺'},
  {'name': 'Icelandic', 'code': 'is', 'flag': '🇮🇸'},
  {'name': 'Indonesian', 'code': 'id', 'flag': '🇮🇩'},
  {'name': 'Italian', 'code': 'it', 'flag': '🇮🇹'},
  {'name': 'Japanese', 'code': 'ja', 'flag': '🇯🇵'},
  {'name': 'Kannada', 'code': 'kn', 'flag': '🇮🇳'},
  {'name': 'Korean', 'code': 'ko', 'flag': '🇰🇷'},
  {'name': 'Latvian', 'code': 'lv', 'flag': '🇱🇻'},
  {'name': 'Lithuanian', 'code': 'lt', 'flag': '🇱🇹'},
  {'name': 'Malay', 'code': 'ms', 'flag': '🇲🇾'},
  {'name': 'Malayalam', 'code': 'ml', 'flag': '🇮🇳'},
  {'name': 'Marathi', 'code': 'mr', 'flag': '🇮🇳'},
  {'name': 'Norwegian', 'code': 'no', 'flag': '🇳🇴'},
  {'name': 'Persian', 'code': 'fa', 'flag': '🇮🇷'},
  {'name': 'Polish', 'code': 'pl', 'flag': '🇵🇱'},
  {'name': 'Portuguese', 'code': 'pt', 'flag': '🇵🇹'},
  {'name': 'Punjabi', 'code': 'pa', 'flag': '🇮🇳'},
  {'name': 'Romanian', 'code': 'ro', 'flag': '🇷🇴'},
  {'name': 'Russian', 'code': 'ru', 'flag': '🇷🇺'},
  {'name': 'Serbian', 'code': 'sr', 'flag': '🇷🇸'},
  {'name': 'Slovak', 'code': 'sk', 'flag': '🇸🇰'},
  {'name': 'Slovenian', 'code': 'sl', 'flag': '🇸🇮'},
  {'name': 'Spanish', 'code': 'es', 'flag': '🇪🇸'},
  {'name': 'Swahili', 'code': 'sw', 'flag': '🇰🇪'},
  {'name': 'Swedish', 'code': 'sv', 'flag': '🇸🇪'},
  {'name': 'Tamil', 'code': 'ta', 'flag': '🇮🇳'},
  {'name': 'Telugu', 'code': 'te', 'flag': '🇮🇳'},
  {'name': 'Thai', 'code': 'th', 'flag': '🇹🇭'},
  {'name': 'Turkish', 'code': 'tr', 'flag': '🇹🇷'},
  {'name': 'Ukrainian', 'code': 'uk', 'flag': '🇺🇦'},
  {'name': 'Urdu', 'code': 'ur', 'flag': '🇵🇰'},
  {'name': 'Vietnamese', 'code': 'vi', 'flag': '🇻🇳'},
  {'name': 'Welsh', 'code': 'cy', 'flag': '🏴'},
  {'name': 'Zulu', 'code': 'zu', 'flag': '🇿🇦'},
];
