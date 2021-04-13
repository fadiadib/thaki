/// Form fields types, add to it any
/// new type you have in your form
enum TkFormField {
  carName,
  carPlateEN,
  carPlateAR,
  carState,
  carModel,
  carMake,
  cardHolder,
  cardNumber,
  cardExpiry,
  cardCVV,
}

/// Mixin class to implement form validations
abstract class TkFormFieldValidatorMixin {
  bool _validating = false;

  // Call this, when you want your screen to start validating its fields
  void startValidating() {
    _validating = true;
  }

  // Call this, when you want your screen to stop validating its fields
  void stopValidating() {
    _validating = false;
  }

  // Check if you are currently validating
  bool get isValidating {
    return _validating;
  }

  // Abstract function to do the actual validations per type of field
  // This has to be implemented in the child class
  bool validateField(TkFormField field, dynamic value);

  // Get the callback function for the form field according to its type
  Function() getValidationCallback(TkFormField field, {dynamic value}) {
    return () => validateField(field, value);
  }

  // Should be called in the form button to return the validation result
  bool validate() {
    for (TkFormField field in TkFormField.values) {
      if (!validateField(field, null)) return false;
    }
    return true;
  }
}
