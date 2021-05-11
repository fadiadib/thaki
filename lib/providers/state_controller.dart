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
  List<TkModel> _models = [];
  List<TkModel> get models => _models;
  List<TkMake> _makes = [];
  List<TkMake> get makes => _makes;
  List<TkColor> _colors = [];
  List<TkColor> get colors => _colors;

  // Error handling
  String _loadError;
  String get loadError => _loadError;

  // Loading
  bool _isLoading;
  bool get isLoading => _isLoading;

  String getAttributeName(int id, TkUser user, List<TkAttribute> data) {
    TkAttribute attribute =
        data.firstWhere((element) => element.id == id, orElse: () => null);
    if (attribute != null) {
      return user.lang.languageCode == 'en'
          ? attribute.nameEN
          : attribute.nameAR;
    }
    return null;
  }

  int getAttributeId(String name, TkUser user, List<TkAttribute> data) {
    TkAttribute attribute = data.firstWhere(
        (element) => element.nameEN == name || element.nameAR == name,
        orElse: () => null);
    if (attribute != null) return attribute.id;

    return null;
  }

  List<String> getAttributeNames(TkUser user, List<TkAttribute> data) {
    List<String> names = [];
    for (TkAttribute attribute in data)
      names.add(
          user.lang.languageCode == 'en' ? attribute.nameEN : attribute.nameAR);
    return names;
  }

  /// States
  String stateName(int id, TkUser user) => getAttributeName(id, user, _states);
  int stateId(String name, TkUser user) => getAttributeId(name, user, _states);
  List<String> stateNames(TkUser user) => getAttributeNames(user, _states);
  Future<bool> loadStates(TkUser user) async {
    _isLoading = true;
    _loadError = null;
    _states.clear();
    notifyListeners();

    Map result = await _apis.loadStates(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kStatesTag]) {
        _states.add(TkState.fromJson(data));
      }
    } else {
      _loadError = _apis.normalizeError(result);
    }

    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }

  /// Makes
  String makeName(int id, TkUser user) => getAttributeName(id, user, _makes);
  int makeId(String name, TkUser user) => getAttributeId(name, user, _makes);
  List<String> makeNames(TkUser user) => getAttributeNames(user, _makes);
  Future<bool> loadMakes(TkUser user) async {
    _isLoading = true;
    _loadError = null;
    _makes.clear();
    notifyListeners();

    Map result = await _apis.loadStates(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kStatesTag]) {
        _makes.add(TkMake.fromJson(data));
      }
    } else {
      _loadError = _apis.normalizeError(result);
    }

    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }
}
