import 'package:email_validator/email_validator.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

class TkValidationHelper {
  static bool validateName(String value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) return false;

    final RegExp exp =
        RegExp(r'([a-zA-Z\u0621-\u064A]{1,20}[ ]{0,1})+$', unicode: true);

    return (exp.stringMatch(value) != null);
  }

  static bool validateAlphaNum(String value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) return false;

    final RegExp exp = RegExp(
        r'([a-zA-Z0-9\u0621-\u064A\u0660-\u0669]{1,100}[ ]{0,1})+$',
        unicode: true);

    return (exp.stringMatch(value) != null);
  }

  static bool validatePassword(String value) {
    if (value == null || value.length < 6 || value.length > 20) return false;

    return true;
  }

  static bool validateNotEmpty(String value) {
    return (value != null && value.isNotEmpty && value.trim().isNotEmpty);
  }

  static bool validateEmail(String value) {
    return (value != null && EmailValidator.validate(value));
  }

  static bool validatePhone(String value) {
    if (value == null) return false;

    // Mach 10 or 11 numeric digits
    RegExp exp = RegExp(r"[\d]{10,11}", unicode: true);
    if (exp.stringMatch(value) == value) return true;

    // Check if the number has a + and 12 digits
    exp = RegExp(r"\+[\d]{12}", unicode: true);
    if (exp.stringMatch(value) == value) return true;

    return false;
  }

  static bool validatePositiveNumber(double value) {
    return (value != null && value > 0);
  }

  static bool validatePastDate(String date) {
    if (date == null) return false;
    DateTime dateTime = DateTime.tryParse(date);
    return (dateTime != null &&
        dateTime.isBefore(DateTime.now().add(Duration(days: 1))));
  }

  static bool validateNationalID(String value) {
    if (value == null) return false;
    String converted = int.tryParse(value).toString();
    if (converted != null && converted.length == 14) {
      if (int.tryParse(converted[0]) <= 3 &&
          int.tryParse(converted.substring(3, 4)) <= 12 &&
          int.tryParse(converted.substring(5, 6)) <= 31) return true;
    }
    return false;
  }

  static bool validateLicense(String value, int state, String langCode) {
    if (value == null) return false;
    if (state == null) return true;

    if (state == 1) {
      if (langCode == 'en') {
        RegExp exp = RegExp(r"\d{1,4}[A-Z]{2,3}");
        return exp.stringMatch(value) == value;
      } else {
        RegExp exp = RegExp(r"([\u0621-\u064A]\s){2,3}[\u0660-\u0669\d]{1,4}",
            unicode: true);
        return exp.stringMatch(value) == value;
      }
    } else {
      RegExp exp = RegExp(r"[\u0660-\u0669\d]{1,7}", unicode: true);
      return exp.stringMatch(value) == value;
    }
  }

  static bool validateCreditCard(String value) {
    if (value == null) return false;

    CreditCardValidator _ccValidator = CreditCardValidator();
    var ccNumResults = _ccValidator.validateCCNum(value);

    return (ccNumResults.isValid);
  }
}
