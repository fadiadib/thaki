import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

import 'lang_controller.dart';

class TkAttributesController extends ChangeNotifier {
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

  String getAttributeName(
      int id, TkLangController langController, List<TkAttribute> data) {
    TkAttribute attribute =
        data.firstWhere((element) => element.id == id, orElse: () => null);
    if (attribute != null) {
      if ((langController.lang.languageCode == 'en' ||
              attribute.nameAR == null) &&
          attribute.nameEN != null)
        return attribute.nameEN;
      else if (attribute.nameAR != null) return attribute.nameAR;
    }
    return null;
  }

  int getAttributeId(String name, List<TkAttribute> data) {
    TkAttribute attribute = data.firstWhere(
        (element) => element.nameEN == name || element.nameAR == name,
        orElse: () => null);
    if (attribute != null) return attribute.id;

    return null;
  }

  List<String> getAttributeNames(
      TkLangController langController, List<TkAttribute> data) {
    List<String> names = [];
    for (TkAttribute attribute in data) {
      if (names.firstWhere(
              (element) =>
                  (element == attribute.nameAR || element == attribute.nameEN),
              orElse: () => null) ==
          null) if ((langController.lang.languageCode == 'en' ||
              attribute.nameAR == null) &&
          attribute.nameEN != null)
        names.add(attribute.nameEN);
      else if (attribute.nameAR != null) names.add(attribute.nameAR);
    }
    return names;
  }

  /// States
  String stateName(int id, TkLangController langController) =>
      getAttributeName(id, langController, _states);
  int stateId(String name) => getAttributeId(name, _states);
  List<String> stateNames(TkLangController langController) =>
      getAttributeNames(langController, _states);

  /// Makes
  String makeName(int id, TkLangController langController) =>
      getAttributeName(id, langController, _makes);
  int makeId(String name) => getAttributeId(name, _makes);
  List<String> makeNames(TkLangController langController) =>
      getAttributeNames(langController, _makes);

  /// Models
  String modelName(int id, TkLangController langController) =>
      getAttributeName(id, langController, _models);
  int modelId(String name) => getAttributeId(name, _models);
  List<String> modelNames(TkLangController langController) =>
      getAttributeNames(langController, _models);

  /// Colors
  String colorName(int id, TkLangController langController) =>
      getAttributeName(id, langController, _colors);
  int colorId(String name) => getAttributeId(name, _colors);
  List<String> colorNames(TkLangController langController) =>
      getAttributeNames(langController, _colors);

  Future<bool> load(TkLangController langController) async {
    if (_states.isNotEmpty) return true;
    _isLoading = true;
    _loadError = null;

    // Clear model
    _states.clear();
    _makes.clear();
    _models.clear();
    _colors.clear();

    // notifyListeners();

    Map result = await _apis.loadAttributes(langController: langController);
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kStatesTag]) {
        _states.add(TkState.fromJson(data));
      }
      if (result[kDataTag][kMakesTag] != null)
        for (Map data in result[kDataTag][kMakesTag]) {
          _makes.add(TkMake.fromJson(data));
        }
      if (result[kDataTag][kColorsTag] != null)
        for (Map data in result[kDataTag][kColorsTag]) {
          _colors.add(TkColor.fromJson(data));
        }
    } else {
      _loadError = _apis.normalizeError(result);
    }

    _isLoading = false;
    // notifyListeners();

    return (_loadError == null);
  }

  Future<bool> loadModels(TkUser user, int makeId, {bool init = false}) async {
    _isLoading = true;
    _loadError = null;

    // Clear model
    _models.clear();
    if (makeId == null) return true;

    if (!init) notifyListeners();

    Map result = await _apis.loadModels(user: user, makeId: makeId);
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kModelsTag]) {
        _models.add(TkModel.fromJson(data));
      }
    } else {
      _loadError = _apis.normalizeError(result);
    }

    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }
}
