import 'package:thaki/globals/index.dart';

class TkCredit {
  TkCredit.fromJson(Map<String, dynamic> json) {
    name = json[kCardNameTag];
    holder = json[kCardHolderTag];
    number = json[kCardNumberTag];
    expiry = json[kCardExpiryTag];
    cvv = json[kCardCVVTag];
    brandPath = json[kCardBrandPathTag];
  }

  String name;
  String holder;
  String number;
  String expiry;
  String cvv;
  String brandPath;
}
