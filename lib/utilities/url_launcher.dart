import 'package:url_launcher/url_launcher.dart' as launcher;

class TkURLLauncher {
  /// Launches a URL into the browser
  static Future<void> launch(String url) async {
    if (!url.startsWith('http')) url = 'http://' + url;
    if (await launcher.canLaunch(url)) await launcher.launch(url);
  }
}
