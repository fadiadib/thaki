import 'package:email_validator/email_validator.dart';
import 'package:credit_card_validator/credit_card_validator.dart';

class TkValidationHelper {
  static bool validateNotEmpty(String value) {
    return (value != null && value.isNotEmpty && value.trim().isNotEmpty);
  }

  static bool validateEmail(String value) {
    return (value != null && EmailValidator.validate(value));
  }

  static bool validatePhone(String value) {
    int number = value != null ? int.tryParse(value) : null;
    return (number != null && value.length == 11);
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
        RegExp exp = RegExp(r"\d{1,4}[A-Z]{3}");
        return exp.stringMatch(value) == value;
      } else {
        RegExp exp =
            RegExp(r"[\u0621-\u064A]{3}[\u0660-\u0669]{1,4}", unicode: true);
        return exp.stringMatch(value) == value;
      }
    } else {
      return (value.length >= 1 && value.length <= 7);
    }
  }

  static bool validateCreditCard(String value) {
    if (value == null) return false;

    CreditCardValidator _ccValidator = CreditCardValidator();
    var ccNumResults = _ccValidator.validateCCNum(value);

    return (ccNumResults.isValid);
  }
}
