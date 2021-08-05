import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

import 'package:thaki/globals/index.dart';

class TkURLLauncher {
  static String _rootURL;

  /// Gets the root URL from firebase Remote Config,
  /// if the root urL was already fetched it is returned
  /// through a static member _rootURL
  static Future<String> getFrontEndRootURL() async {
    if (_rootURL != null) return _rootURL;

    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{kBaseHandle: kDefaultBaseURL};
    await remoteConfig.setDefaults(defaults);

    await remoteConfig.fetch(expiration: const Duration(hours: 12));
    await remoteConfig.activateFetched();

    _rootURL = remoteConfig.getString(kBaseHandle);
    return _rootURL;
  }

  /// Launches a URL into the browser
  static Future<void> launch(String url) async {
    if (!url.startsWith('http')) url = 'http://' + url;
    if (await launcher.canLaunch(url)) await launcher.launch(url);
  }

  /// Launches a sub URL of the base URl into the browser
  static Future<void> launchBase(String url) async {
    url = await getFrontEndRootURL() + '/' + url;
    if (await launcher.canLaunch(url)) await launcher.launch(url);
  }
}
