import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:thaki/globals/index.dart';

import 'index.dart';
import 'package:thaki/globals/apiuris.dart';
import 'package:thaki/utilities/index.dart';

class TkUser {
  void updateModelFromInfoFields(TkInfoFieldsList fields) {
    for (TkInfoField field in fields.fields) {
      // if (field.name == kUserNameTag) name = field.value;
      if (field.name == kUserEmailTag) email = field.value;
      if (field.name == kUserPhoneTag) phone = field.value;
      if (field.name == kUserBirthDateTag)
        birthDate = DateTime.tryParse(field.value.toString());
      if (field.name == kUserPasswordTag) password = field.value;
      if (field.name == kUserConfirmPasswordTag) confirmPassword = field.value;
      if (field.name == kUserOldPasswordTag) oldPassword = field.value;
      if (field.name == kUserRememberTag) rememberMe = field.value == 'true';
      if (field.name == kUserOTPTag) otp = field.value;
    }
  }

  TkUser.fromInfoFields(TkInfoFieldsList fields) {
    updateModelFromInfoFields(fields);
  }

  void updateModelFromJson(Map<String, dynamic> json) {
    if (json[kUserTokenTag] != null) token = json[kUserTokenTag];
    if (json[kUserTokenTypeTag] != null) tokenType = json[kUserTokenTypeTag];
    if (json[kUserTag] != null) {
      // name = json[kUserTag][kUserNameTag];
      firstName = json[kUserTag][kUserFirstNameTag];
      middleName = json[kUserTag][kUserMiddleNameTag];
      lastName = json[kUserTag][kUserLastNameTag];
      gender = json[kUserTag][kUserGenderTag];
      nationality =
          int.tryParse(json[kUserTag][kUserNationalityTag].toString());
      userType = int.tryParse(json[kUserTag][kUserDriverTypeTag].toString());

      email = json[kUserTag][kUserEmailTag];
      phone = json[kUserTag][kUserPhoneTag];
      birthDate =
          DateTime.tryParse(json[kUserTag][kUserBirthDateTag].toString());
      isApproved = int.tryParse(json[kUserTag][kUserApprovedTag].toString());
      isSocial = json[kUserTag][kUserSocialTag] == true;
      socialToken = json[kUserTag][kUserSocialTokenTag];
      loginType = json[kUserTag][kUserLoginTypeTag];
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
      kLangTag: lang?.languageCode,
      kAuthTag: '$tokenType $token',
    };
  }

  Future<Map<String, dynamic>> toJson() async {
    Map<String, dynamic> result = {
      // kUserNameTag: name,
      kUserFirstNameTag: firstName,
      kUserMiddleNameTag: middleName,
      kUserLastNameTag: lastName,
      kUserGenderTag: gender,
      kUserNationalityTag: nationality.toString(),
      kUserDriverTypeTag: userType.toString(),
      kUserEmailTag: email,
      kUserPhoneTag: phone,
      kUserBirthDateTag: birthDate.toString().split(' ').first,
      kFBTokenTag: await FirebaseMessaging().getToken(),
    };
    if (password != null)
      result[kUserPasswordTag] = TkCryptoHelper.hashSha256(password);
    if (confirmPassword != null)
      result[kUserConfirmPasswordTag] =
          TkCryptoHelper.hashSha256(confirmPassword);
    if (oldPassword != null)
      result[kUserOldPasswordTag] = TkCryptoHelper.hashSha256(oldPassword);

    return result;
  }

  Future<Map<String, dynamic>> toLoginJson() async {
    return {
      kUserEmailTag: email,
      kUserPasswordTag: TkCryptoHelper.hashSha256(password),
      kFBTokenTag: await FirebaseMessaging().getToken(),
    };
  }

  Future<Map<String, dynamic>> toSocialLoginJson() async {
    return {
      kUserFirstNameTag: firstName ?? '',
      kUserMiddleNameTag: middleName ?? '',
      kUserLastNameTag: lastName ?? '',
      kUserGenderTag: gender ?? '',
      kUserEmailTag: email ?? '',
      kUserPhoneTag: phone ?? '',
      kUserBirthDateTag:
          birthDate != null ? birthDate.toString().split('.').first : '',
      kFBTokenTag: await FirebaseMessaging().getToken(),
      kUserSocialTokenTag: socialToken,
      kUserLoginTypeTag: loginType,
    };
  }

  Future<Map<String, dynamic>> toForgotPasswordJson() async {
    return {kUserEmailTag: email};
  }

  Future<Map<String, dynamic>> toOTPJson() async {
    return {
      kUserEmailTag: email,
      kUserOTPTag: otp,
      kUserPasswordTag: TkCryptoHelper.hashSha256(password),
      kUserConfirmPasswordTag: TkCryptoHelper.hashSha256(confirmPassword),
    };
  }

  Future<Map<String, dynamic>> toLoadJson() async {
    return {
      kFBTokenTag: await FirebaseMessaging().getToken(),
    };
  }

  TkInfoFieldsList toInfoFields(TkInfoFieldsList fields) {
    String fullName = firstName;
    if (middleName != null) fullName += ' $middleName';
    if (lastName != null) fullName += ' $lastName';

    for (TkInfoField field in fields.fields) {
      if (field.name == kUserNameTag) field.value = fullName;
      if (field.name == kUserEmailTag) field.value = email;
      if (field.name == kUserPhoneTag) field.value = phone;
      if (field.name == kUserBirthDateTag) field.value = birthDate?.toString();
    }
    return fields;
  }

  bool get needsUpdate {
    return email == null ||
        phone == null ||
        firstName == null ||
        middleName == null ||
        lastName == null;
  }

  Locale lang;
  String token;
  String tokenType;

  String email;
  String otp;
  DateTime birthDate;
  String password;
  String confirmPassword;
  String oldPassword;
  String phone;
  String socialToken;
  String loginType;
  bool isSocial;
  bool rememberMe;
  int isApproved;
  List<TkCar> cars;
  List<TkCredit> cards;

  int nationality;
  int userType;
  String gender;
  String firstName;
  String middleName;
  String lastName;
}
