class TkCreditCardHelper {
  static String obscure(String number, String langCode) {
    if (number == null) return number;
    return fix(number, langCode);
    // return number.substring(0, 4) + ' XXXX XXXX ' + number.substring(12);
  }

  static String fix(String number, String langCode) {
    if (langCode == 'en') return number;

    List<String> numbers = number.split(' ');
    if (numbers.length != 4) return number;
    return "${numbers[3]} ${numbers[2]} ${numbers[1]} ${numbers[0]}";
  }
}
