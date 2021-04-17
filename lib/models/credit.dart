import 'package:thaki/globals/index.dart';

class TkCredit {
  TkCredit.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kCardIdTag].toString());
    holder = json[kCardHolderTag];
    number = json[kCardNumberTag];
    expiry = json[kCardExpiryTag];
    cvv = json[kCardCVVTag];
    preferred = json[kCardPreferredTag].toString() == '1';
    type = int.tryParse(json[kCardTypeTag].toString());
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

  TkCredit createCopy() {
    return TkCredit.fromJson({})
      ..id = id
      ..holder = holder
      ..number = number
      ..expiry = expiry
      ..cvv = cvv
      ..type = type
      ..preferred = preferred;
  }

  void copyValue(TkCredit card) {
    id = card.id;
    holder = card.holder;
    number = card.number;
    expiry = card.expiry;
    cvv = card.cvv;
    preferred = card.preferred;
    type = card.type;
  }

  int id;
  String holder;
  String number;
  String expiry;
  String cvv;
  bool preferred;

  int type; // for internal use
}
