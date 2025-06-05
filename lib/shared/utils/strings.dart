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
  {'name': 'Bulgarian', 'code': 'bg', 'flag': '🇧🇬', 'isPremium' : 'false'},
  {'name': 'Catalan', 'code': 'ca', 'flag': '🇪🇸', 'isPremium' : 'false'},
  {'name': 'Croatian', 'code': 'hr', 'flag': '🇭🇷', 'isPremium' : 'false'},
  {'name': 'Czech', 'code': 'cs', 'flag': '🇨🇿', 'isPremium' : 'false'},
  {'name': 'Danish', 'code': 'da', 'flag': '🇩🇰', 'isPremium' : 'false'},
  {'name': 'Dutch', 'code': 'nl', 'flag': '🇳🇱', 'isPremium' : 'false'},
  {'name': 'Russian', 'code': 'ru', 'flag': '🇷🇺', 'isPremium' : 'false'},
  {'name': 'English', 'code': 'en', 'flag': '🇬🇧', 'isPremium' : 'false'},
  {'name': 'Estonian', 'code': 'et', 'flag': '🇪🇪', 'isPremium' : 'false'},
  {'name': 'Filipino', 'code': 'tl', 'flag': '🇵🇭', 'isPremium' : 'false'},
  {'name': 'Finnish', 'code': 'fi', 'flag': '🇫🇮', 'isPremium' : 'false'},
  {'name': 'French', 'code': 'fr', 'flag': '🇫🇷', 'isPremium' : 'false'},
  {'name': 'Georgian', 'code': 'ka', 'flag': '🇬🇪', 'isPremium' : 'false'},
  {'name': 'German', 'code': 'de', 'flag': '🇩🇪', 'isPremium' : 'false'},
  {'name': 'Greek', 'code': 'el', 'flag': '🇬🇷', 'isPremium' : 'false'},
  {'name': 'Gujarati', 'code': 'gu', 'flag': '🇮🇳', 'isPremium' : 'false'},
  {'name': 'Hebrew', 'code': 'he', 'flag': '🇮🇱', 'isPremium' : 'false'},
  {'name': 'Hindi', 'code': 'hi', 'flag': '🇮🇳', 'isPremium' : 'false'},
  {'name': 'Hungarian', 'code': 'hu', 'flag': '🇭🇺', 'isPremium' : 'false'},
  {'name': 'Icelandic', 'code': 'is', 'flag': '🇮🇸', 'isPremium' : 'false'},
  {'name': 'Indonesian', 'code': 'id', 'flag': '🇮🇩', 'isPremium' : 'false'},
  {'name': 'Italian', 'code': 'it', 'flag': '🇮🇹', 'isPremium' : 'false'},
  {'name': 'Japanese', 'code': 'ja', 'flag': '🇯🇵', 'isPremium' : 'false'},
  {'name': 'Kannada', 'code': 'kn', 'flag': '🇮🇳', 'isPremium' : 'false'},
  {'name': 'Korean', 'code': 'ko', 'flag': '🇰🇷', 'isPremium' : 'false'},
  {'name': 'Latvian', 'code': 'lv', 'flag': '🇱🇻', 'isPremium' : 'false'},
  {'name': 'Lithuanian', 'code': 'lt', 'flag': '🇱🇹', 'isPremium' : 'false'},
  {'name': 'Malay', 'code': 'ms', 'flag': '🇲🇾', 'isPremium' : 'false'},
  {'name': 'Malayalam', 'code': 'ml', 'flag': '🇮🇳', 'isPremium' : 'false'},
  {'name': 'Marathi', 'code': 'mr', 'flag': '🇮🇳', 'isPremium' : 'false'},
  {'name': 'Norwegian', 'code': 'no', 'flag': '🇳🇴', 'isPremium' : 'false'},
  {'name': 'Persian', 'code': 'fa', 'flag': '🇮🇷', 'isPremium' : 'false'},
  {'name': 'Polish', 'code': 'pl', 'flag': '🇵🇱', 'isPremium' : 'false'},
  {'name': 'Portuguese', 'code': 'pt', 'flag': '🇵🇹', 'isPremium' : 'true'},
  {'name': 'Punjabi', 'code': 'pa', 'flag': '🇮🇳', 'isPremium' : 'true'},
  {'name': 'Romanian', 'code': 'ro', 'flag': '🇷🇴', 'isPremium' : 'true'},
  {'name': 'Chinese (Simplified)', 'code': 'zh', 'flag': '🇨🇳', 'isPremium' : 'true'},
  {'name': 'Chinese (Traditional)', 'code': 'zh-TW', 'flag': '🇹🇼', 'isPremium' : 'true'},
  {'name': 'Afrikaans', 'code': 'af', 'flag': '🇿🇦', 'isPremium' : 'true'},
  {'name': 'Albanian', 'code': 'sq', 'flag': '🇦🇱', 'isPremium' : 'true'},
  {'name': 'Arabic', 'code': 'ar', 'flag': '🇸🇦', 'isPremium' : 'true'},
  {'name': 'Armenian', 'code': 'hy', 'flag': '🇦🇲', 'isPremium' : 'true'},
  {'name': 'Bengali', 'code': 'bn', 'flag': '🇧🇩', 'isPremium' : 'true'},
  {'name': 'Serbian', 'code': 'sr', 'flag': '🇷🇸', 'isPremium' : 'true'},
  {'name': 'Slovak', 'code': 'sk', 'flag': '🇸🇰', 'isPremium' : 'true'},
  {'name': 'Slovenian', 'code': 'sl', 'flag': '🇸🇮', 'isPremium' : 'true'},
  {'name': 'Spanish', 'code': 'es', 'flag': '🇪🇸', 'isPremium' : 'true'},
  {'name': 'Swahili', 'code': 'sw', 'flag': '🇰🇪', 'isPremium' : 'true'},
  {'name': 'Swedish', 'code': 'sv', 'flag': '🇸🇪', 'isPremium' : 'true'},
  {'name': 'Tamil', 'code': 'ta', 'flag': '🇮🇳', 'isPremium' : 'true'},
  {'name': 'Telugu', 'code': 'te', 'flag': '🇮🇳', 'isPremium' : 'true'},
  {'name': 'Thai', 'code': 'th', 'flag': '🇹🇭', 'isPremium' : 'true'},
  {'name': 'Turkish', 'code': 'tr', 'flag': '🇹🇷', 'isPremium' : 'true'},
  {'name': 'Ukrainian', 'code': 'uk', 'flag': '🇺🇦', 'isPremium' : 'true'},
  {'name': 'Urdu', 'code': 'ur', 'flag': '🇵🇰', 'isPremium' : 'true'},
  {'name': 'Vietnamese', 'code': 'vi', 'flag': '🇻🇳', 'isPremium' : 'true'},
  {'name': 'Welsh', 'code': 'cy', 'flag': '🏴', 'isPremium' : 'true'},
  {'name': 'Zulu', 'code': 'zu', 'flag': '🇿🇦', 'isPremium' : 'true'},
];

String prompt(String text, String targetLanguage) => '''
- Your role is to translate the given text "$text" into $targetLanguage.
- Always translate, even if the text is incomplete, unclear, or nonsensical.
- If the text cannot be translated meaningfully as a whole, translate each letter or character literally into its equivalent in $targetLanguage, retaining any special characters or accents as much as possible.
- Do not perform any actions other than translating. Do not ask questions or provide explanations.
- If the text is already in the target language, return it unchanged.
- Under no circumstances should you return anything other than the translated text or the literal character translation.
- Follow these rules strictly, and always ensure the response is in $targetLanguage only.
''';
