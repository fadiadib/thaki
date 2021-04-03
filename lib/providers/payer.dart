import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkPayer extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  List<TkViolation> _violations = [];
  List<TkViolation> get violations => _violations;
  String _selectedCar;
  String get selectedCar => _selectedCar;
  set selectedCar(String car) {
    _selectedCar = car;
    _validationCarError = null;

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
  String _loadError;
  String get loadError => _loadError;
  String _payError;
  String get payError => _payError;

  // Validation
  String _validationViolationsError;
  String get validationViolationsError => _validationViolationsError;
  bool validateViolations() {
    if (_selectedViolations == null || _selectedViolations.isEmpty) {
      _validationViolationsError = kSelectViolationToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  String _validationPaymentError;
  String get validationPaymentError => _validationPaymentError;
  bool validatePayment() {
    if (_selectedCard == null) {
      _validationPaymentError = kSelectPaymentToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  String _validationCarError;
  String get validationCarError => _validationCarError;
  bool validateCar() {
    if (_selectedCar == null || _selectedCar.isEmpty) {
      _validationCarError = kSelectCardToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  /// Load violations
  Future<bool> loadViolations() async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.loadViolations(selectedCar);

    // Clear model
    _loadError = null;
    _violations.clear();
    _selectedViolations.clear();

    if (result[kStatusTag] == kSuccessCode) {
      for (Map<String, dynamic> json in result[kDataTag][kViolationsTag]) {
        _violations.add(TkViolation.fromJson(json));
      }
    } else {
      // an error happened
      _loadError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }

  /// Pay for selected violations using selected card
  Future<bool> paySelectedViolations() async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.payViolations(
        violations: selectedViolations, card: selectedCard);

    // Clear model
    _payError = null;

    if (result[kStatusTag] != kSuccessCode) {
      // an _purchaseError happened
      _payError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_payError == null);
  }
}
