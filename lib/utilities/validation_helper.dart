import 'package:email_validator/email_validator.dart';

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
}
