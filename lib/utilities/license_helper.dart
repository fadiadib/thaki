class TkLicenseHelper {
  static String? formatARLicensePlate(String licensePlate) {
    final String? chars = RegExp(r"([\u0621-\u064A]){2,3}", unicode: true)
        .stringMatch(licensePlate);
    final String? digits =
        RegExp(r"[\u0660-\u0669\d]+", unicode: true).stringMatch(licensePlate);

    return chars == null ? digits : chars.split('').join(' ') + ' ' + digits!;
  }
}
