import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/providers/lang_controller.dart';

class TkOnBoardingController extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model variables
  List<TkScreen> _onBoardingList = [];
  List<TkScreen> get onBoardingList => _onBoardingList;

  // Loading variable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error variables
  String _error;
  String get error => _error;

  /// Checks that the server is alive
  Future<bool> load(TkLangController langController) async {
    // Start any loading indicators
    _isLoading = true;
    _error = null;
    _onBoardingList.clear();

    // Call API to check  if the server is alive
    Map result = await _apis.loadOnboarding(langController: langController);

    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kOnBoardingTag]) {
        _onBoardingList.add(TkScreen.fromJson(data));
      }
    } else {
      // an error happened
      _error = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;

    // Notify listeners (Provider pattern)
    notifyListeners();

    return (_error == null);
  }
}
