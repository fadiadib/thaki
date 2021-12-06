import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/providers/lang_controller.dart';

class TkUserAttributesController extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  List<TkNationality> nationalities = [];
  List<TkUserType> types = [];

  // Error handling
  String? _loadError;
  String? get loadError => _loadError;

  // Loading
  bool? _isLoading;
  bool? get isLoading => _isLoading;

  String? getAttributeName(
      int? id, TkLangController langController, List<TkAttribute> data) {
    TkAttribute? attribute =
        data.firstWhereOrNull((element) => element.id == id);
    if (attribute != null) {
      if ((langController.lang!.languageCode == 'en' ||
              attribute.nameAR == null) &&
          attribute.nameEN != null)
        return attribute.nameEN;
      else if (attribute.nameAR != null) return attribute.nameAR;
    }
    return null;
  }

  int? getAttributeId(String name, List<TkAttribute> data) {
    TkAttribute? attribute = data.firstWhereOrNull(
        (element) => element.nameEN == name || element.nameAR == name);
    if (attribute != null) return attribute.id;

    return null;
  }

  List<String?> getAttributeNames(
      TkLangController langController, List<TkAttribute> data) {
    List<String?> names = [];
    for (TkAttribute attribute in data) {
      if (names.firstWhere(
              (element) =>
                  (element == attribute.nameAR || element == attribute.nameEN),
              orElse: () => null) ==
          null) if ((langController.lang!.languageCode == 'en' ||
              attribute.nameAR == null) &&
          attribute.nameEN != null)
        names.add(attribute.nameEN);
      else if (attribute.nameAR != null) names.add(attribute.nameAR);
    }
    return names;
  }

  /// Nationalities
  String? nationalityName(int? id, TkLangController langController) =>
      getAttributeName(id, langController, nationalities);
  int? nationalityId(String name) => getAttributeId(name, nationalities);
  List<String?> nationalityNames(TkLangController langController) =>
      getAttributeNames(langController, nationalities);

  /// User types
  String? userTypeName(int? id, TkLangController langController) =>
      getAttributeName(id, langController, types);
  int? userTypeId(String name) => getAttributeId(name, types);
  List<String?> userTypesNames(TkLangController langController) =>
      getAttributeNames(langController, types);

  /// Load user attributes
  Future<bool> load() async {
    _isLoading = true;
    _loadError = null;

    // Clear model
    nationalities.clear();
    types.clear();
    notifyListeners();

    Map result = await _apis.loadUserAttributes();
    if (result[kStatusTag] == kSuccessCode) {
      // Load nationalities
      for (Map data in result[kDataTag][kNationalitiesTag])
        nationalities.add(TkNationality.fromJson(data as Map<String, dynamic>));

      // Load user types
      for (Map data in result[kDataTag][kTypesTag])
        types.add(TkUserType.fromJson(data as Map<String, dynamic>));
    } else {
      _loadError = _apis.normalizeError(result);
    }

    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }
}
