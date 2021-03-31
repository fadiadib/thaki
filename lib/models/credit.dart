import 'package:thaki/globals/index.dart';

class TkCredit {
  TkCredit.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kCardIdTag].toString());
    name = json[kCardNameTag];
    holder = json[kCardHolderTag];
    number = json[kCardNumberTag];
    expiry = json[kCardExpiryTag];
    cvv = json[kCardCVVTag];
    brandPath = json[kCardBrandPathTag];
    preferred = json[kCardPreferredTag] ?? false;
    type = json[kCardTypeTag];
  }

  int id;
  String name;
  String holder;
  String number;
  String expiry;
  String cvv;
  String brandPath;
  int type;
  bool preferred;
}
