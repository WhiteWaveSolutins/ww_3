//
import 'package:ai_translator/src/features/main/ui/main.dart';

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

If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.  The prohibited or acceptable use clause in your terms of use agreement outlines all rules your users must follow when accessing your services.
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

If your website or app gives users a lot of control and freedom while using your services, consider putting multiple use clauses within your terms of use.  ''';

final historyItems = [
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'a very long text',
      translation:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...'),
  HistoryItem(
      countries: ['usa', 'france'],
      word:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit, Lorem ipsum dolor sit amet, consectetuer adipiscing elit..., Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
  HistoryItem(
      countries: ['usa', 'france'],
      word: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit...',
      translation: 'a very long translated text'),
];
