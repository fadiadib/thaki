import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/utilities/index.dart';

class TkPayer extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  List<TkViolation> _violations = [];
  List<TkViolation> get violations => _violations;
  TkCar _selectedCar;
  TkCar get selectedCar => _selectedCar;
  set selectedCar(TkCar car) {
    _selectedCar = car;
    _validationCarError = null;

    notifyListeners();
  }

  bool allowChange = true;

  String _cvv;
  String get cvv => _cvv;
  set cvv(String value) {
    _cvv = value;
    notifyListeners();
  }

  List<TkViolation> _selectedViolations = [];
  List<TkViolation> get selectedViolations => _selectedViolations;
  void toggleSelection(TkViolation violation) {
    TkViolation found = _selectedViolations.firstWhere(
        (element) => element.id == violation.id,
        orElse: () => null);
    if (found != null) {
      // Violation found, remove it
      _selectedViolations.remove(found);
    } else {
      _selectedViolations.add(violation);
    }
    _validationViolationsError = null;

    notifyListeners();
  }

  TkCredit _selectedCard;
  TkCredit get selectedCard => _selectedCard;
  set selectedCard(TkCredit card) {
    _selectedCard = card;
    _validationPaymentError = null;

    notifyListeners();
  }

  // Validation
  String _validationPaymentError;
  String get validationPaymentError => _validationPaymentError;
  bool validatePayment(BuildContext context) {
    if (_selectedCard == null) {
      _validationPaymentError = S.of(context).kSelectPaymentToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  double getSelectedViolationsFine() {
    double fine = 0;
    for (TkViolation violation in _selectedViolations) {
      fine += violation.fine;
    }
    return fine;
  }

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  String loadError;
  String payError;

  // Validation
  String _validationViolationsError;
  String get validationViolationsError => _validationViolationsError;
  bool validateViolations(BuildContext context) {
    if (_selectedViolations == null || _selectedViolations.isEmpty) {
      _validationViolationsError = S.of(context).kSelectViolationToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  String _validationCarError;
  String get validationCarError => _validationCarError;
  bool validateCar(BuildContext context) {
    if (_selectedCar == null ||
        _selectedCar.plateEN == null ||
        _selectedCar.plateEN.isEmpty ||
        !TkValidationHelper.validateLicense(
            _selectedCar.plateEN, _selectedCar.state, 'en')) {
      _validationCarError = S.of(context).kSelectCardToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  /// Load violations
  Future<bool> loadViolations(TkUser user, TkLangController langController,
      {bool guest = false}) async {
    // Start any loading indicators
    _isLoading = true;

    // Clear model
    loadError = null;
    _validationViolationsError = null;
    _validationCarError = null;
    _violations.clear();
    _selectedViolations.clear();
    _cvv = null;

    Map result = Map();
    if (!guest)
      result = await _apis.loadViolations(selectedCar.plateEN, user);
    else
      result = await _apis.loadViolationsWithoutToken(
          selectedCar.plateEN, langController);

    if (result[kStatusTag] == kSuccessCode) {
      for (Map<String, dynamic> json in result[kDataTag][kViolationsTag]) {
        _violations.add(TkViolation.fromJson(json));
      }
    } else {
      // an error happened
      loadError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadError == null);
  }

  /// Pay for selected violations using selected card
  Future<bool> paySelectedViolations() async {
    // Start any loading indicators
    _isLoading = true;
    payError = null;

    notifyListeners();

    Map result = await _apis.payViolations(
        violations: selectedViolations, card: selectedCard, cvv: _cvv);

    if (result[kStatusTag] != kSuccessCreationCode) {
      payError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (payError == null);
  }
}
