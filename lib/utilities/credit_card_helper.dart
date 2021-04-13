class TkCreditCardHelper {
  static String obscure(String number) {
    return number;
    // return number.substring(0, 4) + ' XXXX XXXX ' + number.substring(12);
  }
}
