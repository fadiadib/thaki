import 'dart:ui';

import 'package:thaki/globals/index.dart';

import 'index.dart';
import 'package:thaki/globals/apiuris.dart';
import 'package:thaki/utilities/index.dart';

class TkUser {
  void updateModelFromInfoFields(TkInfoFieldsList fields) {
    for (TkInfoField field in fields.fields) {
      if (field.name == kUserNameTag) name = field.value;
      if (field.name == kUserEmailTag) email = field.value;
      if (field.name == kUserPhoneTag) phone = field.value;
      if (field.name == kUserBirthDateTag)
        birthDate = DateTime.tryParse(field.value.toString());
      if (field.name == kUserPasswordTag) password = field.value;
      if (field.name == kUserConfirmPasswordTag) confirmPassword = field.value;
      if (field.name == kUserRememberTag) rememberMe = field.value == 'true';
    }
  }

  void updateModelFromJson(Map<String, dynamic> json) {
    if (json[kUserTokenTag] != null) token = json[kUserTokenTag];
    if (json[kUserTokenTypeTag] != null) tokenType = json[kUserTokenTypeTag];
    if (json[kUserTag] != null) {
      name = json[kUserTag][kUserNameTag];
      email = json[kUserTag][kUserEmailTag];
      phone = json[kUserTag][kUserPhoneTag];
      birthDate =
          DateTime.tryParse(json[kUserTag][kUserBirthDateTag].toString());
      isApproved = int.tryParse(json[kUserTag][kUserApprovedTag].toString());
    }
    if (json[kUserLangTag] != null) {
      String langCode = json[kUserLangTag];
      if (langCode == null) {
        // No language selected, choose default
        langCode = 'en';
        if (kDefaultToAR) langCode = 'ar';
      }

      if (langCode == 'en') {
        lang = Locale('en', '');
      } else {
        lang = Locale('ar', '');
      }
    }

    // Create user cars
    if (json[kUserCarsTag] != null) {
      cars = [];
      for (Map<String, dynamic> carJson in json[kUserCarsTag])
        cars.add(TkCar.fromJson(carJson));
    }

    // Create user credit cards
    if (json[kUserCardsTag] != null) {
      cards = [];
      for (Map<String, dynamic> cardJson in json[kUserCardsTag]) {
        TkCredit card = TkCredit.fromJson(cardJson);
        if (card.preferred)
          cards.insert(0, card);
        else
          cards.add(card);
      }
    }
  }

  TkUser.fromJson(Map<String, dynamic> json) {
    updateModelFromJson(json);
  }

  Map<String, String> toHeader() {
    return {
      kLangTag: lang.languageCode,
      kAuthTag: '$tokenType $token',
    };
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = {
      kUserNameTag: name,
      kUserEmailTag: email,
      kUserPhoneTag: phone,
      kUserBirthDateTag: birthDate.toString().split('.').first,
    };
    if (password != null)
      result[kUserPasswordTag] = TkCryptoHelper.hashSha256(password);
    if (confirmPassword != null)
      result[kUserConfirmPasswordTag] =
          TkCryptoHelper.hashSha256(confirmPassword);

    // TODO: add firebase token
    return result;
  }

  Map<String, dynamic> toLoginJson() {
    // TODO: add firebase token
    return {
      kUserEmailTag: email,
      kUserPasswordTag: TkCryptoHelper.hashSha256(password),
    };
  }

  TkUser.fromInfoFields(TkInfoFieldsList fields) {
    updateModelFromInfoFields(fields);
  }

  TkInfoFieldsList toInfoFields(TkInfoFieldsList fields) {
    for (TkInfoField field in fields.fields) {
      if (field.name == kUserNameTag) field.value = name;
      if (field.name == kUserEmailTag) field.value = email;
      if (field.name == kUserPhoneTag) field.value = phone;
      if (field.name == kUserBirthDateTag) field.value = birthDate?.toString();
      if (field.name == kUserPasswordTag) field.value = password;
      if (field.name == kUserConfirmPasswordTag) field.value = confirmPassword;
    }
    return fields;
  }

  Locale lang;
  String token;
  String tokenType;
  String name;
  String email;
  DateTime birthDate;
  String password;
  String confirmPassword;
  String phone;
  bool rememberMe;
  int isApproved;
  List<TkCar> cars;
  List<TkCredit> cards;
}
