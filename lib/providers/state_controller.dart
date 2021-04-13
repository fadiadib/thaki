import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkStateController extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  List<TkState> _states = [];
  List<TkState> get states => _states;

  // Error handling
  String _loadError;
  String get loadError => _loadError;

  // Loading
  bool _isLoading;
  bool get isLoading => _isLoading;

  String getStateName(int id, TkUser user) {
    TkState state =
        _states.firstWhere((element) => element.id == id, orElse: () => null);
    if (state != null) {
      return user.lang.languageCode == 'en' ? state.nameEN : state.nameAR;
    }
    return null;
  }

  int getStateId(String name, TkUser user) {
    TkState state = _states.firstWhere(
        (element) => element.nameEN == name || element.nameAR == name,
        orElse: () => null);
    if (state != null) return state.id;

    return null;
  }

  List<String> getStateNames(TkUser user) {
    List<String> states = [];
    for (TkState state in _states)
      states.add(user.lang.languageCode == 'en' ? state.nameEN : state.nameAR);
    return states;
  }

  Future<bool> loadStates(TkUser user) async {
    _isLoading = true;
    _loadError = null;
    _states.clear();
    notifyListeners();

    Map result = await _apis.loadStates(user: user);
    if (result[kStatusTag] != kSuccessCode) {
      _loadError = result[kErrorMessageTag] ?? kUnknownError;
    } else {
      for (Map data in result[kDataTag][kStatesTag]) {
        _states.add(TkState.fromJson(data));
      }
    }

    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }
}
