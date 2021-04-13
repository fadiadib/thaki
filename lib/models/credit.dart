import 'package:thaki/globals/index.dart';

class TkCredit {
  TkCredit.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kCardIdTag].toString());
    holder = json[kCardHolderTag];
    number = json[kCardNumberTag];
    expiry = json[kCardExpiryTag];
    cvv = json[kCardCVVTag];
    preferred = json[kCardPreferredTag].toString() == '1';
    type = json[kCardTypeTag] ?? 1;
  }

  Map<String, dynamic> toJson() {
    return {
      kCardHolderTag: holder,
      kCardNumberTag: number,
      kCardExpiryTag: expiry,
      kCardCVVTag: cvv,
      kCardPreferredTag: preferred ? '1' : '0',
    };
  }

  int id;
  String holder;
  String number;
  String expiry;
  String cvv;
  bool preferred;

  int type; // for internal use
}
