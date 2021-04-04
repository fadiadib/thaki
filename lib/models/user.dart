import 'package:thaki/utilities/crypto_helper.dart';

import 'index.dart';
import 'package:thaki/globals/apiuris.dart';

class TkUser {
  TkUser.fromJson(Map<String, dynamic> json) {
    token = json[kUserTokenTag];
    name = json[kUserNameTag];
    email = json[kUserEmailTag];
    phone = json[kUserPhoneTag];

    // Create user cars
    cars = [];
    if (json[kUserCarsTag] != null)
      for (Map<String, dynamic> carJson in json[kUserCarsTag])
        cars.add(TkCar.fromJson(carJson));

    // Create user credit cards
    cards = [];
    if (json[kUserCardsTag] != null)
      for (Map<String, dynamic> cardJson in json[kUserCardsTag])
        cards.add(TkCredit.fromJson(cardJson));
  }

  Map<String, dynamic> toJson() {
    return {
      kUserNameTag: name,
      kUserEmailTag: email,
      kUserPhoneTag: phone,
      kUserPasswordTag: TkCryptoHelper.hashSha256(password),
      kUserConfirmPasswordTag: TkCryptoHelper.hashSha256(confirmPassword)
    };
  }

  Map<String, dynamic> toLoginJson() {
    return {
      kUserEmailTag: email,
      kUserPasswordTag: TkCryptoHelper.hashSha256(password),
    };
  }

  TkUser.fromInfoFields(TkInfoFieldsList fields) {
    for (TkInfoField field in fields.fields) {
      if (field.name == kUserNameTag) name = field.value;
      if (field.name == kUserEmailTag) email = field.value;
      if (field.name == kUserPhoneTag) phone = field.value;
      if (field.name == kUserPasswordTag) password = field.value;
      if (field.name == kUserConfirmPasswordTag) confirmPassword = field.value;
      if (field.name == kUserRememberTag) rememberMe = field.value == true;
    }
  }

  TkInfoFieldsList toInfoFields(TkInfoFieldsList fields) {
    for (TkInfoField field in fields.fields) {
      if (field.name == kUserNameTag) field.value = name;
      if (field.name == kUserEmailTag) field.value = email;
      if (field.name == kUserPhoneTag) field.value = phone;
      if (field.name == kUserPasswordTag) field.value = password;
      if (field.name == kUserConfirmPasswordTag) field.value = confirmPassword;
    }
    return fields;
  }

  String token;
  String name;
  String email;
  String password;
  String confirmPassword;
  String phone;
  bool rememberMe;
  List<TkCar> cars;
  List<TkCredit> cards;
}
