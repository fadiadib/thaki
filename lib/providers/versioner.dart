import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

class TkVersioner extends ChangeNotifier {
  // Model variables
  String? _version;
  String? _build;
  String? get version => _version;
  String? get build => _build;

  void initVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _version = packageInfo.version;
    _build = packageInfo.buildNumber;

    notifyListeners();
  }
}
