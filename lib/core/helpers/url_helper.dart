
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {

  static Future<void> launchURL(String link) async {
    final Uri url = Uri.parse(link);
    try {
      await launchUrl(url);
    } catch (e) {
      throw 'Could not launch $link';
    }
  }
}