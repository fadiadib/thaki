import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/models/info_fields.dart';
import 'package:thaki/utilities/crypto_helper.dart';

class TkPermit {
  String name;
  String phone;
  String email;
  List<TkDocument> documents;

  void updateModelFromInfoFields(TkInfoFieldsList fields) {
    for (TkInfoField field in fields.fields) {
      if (field.name == kUserNameTag) name = field.value;
      if (field.name == kUserEmailTag) email = field.value;
      if (field.name == kUserPhoneTag) phone = field.value;
    }
  }

  List<http.MultipartFile> toFiles() {
    List<http.MultipartFile> files = [];
    for (TkDocument doc in documents) {
      files.add(
        http.MultipartFile(
          doc.tag,
          doc.image.readAsBytes().asStream(),
          doc.image.lengthSync(),
          filename: TkCryptoHelper.hashMD5(
              Random().toString() + '_' + DateTime.now().toString()),
        ),
      );
    }
    return files;
  }

  TkPermit.fromInfoFields(TkInfoFieldsList fields) {
    updateModelFromInfoFields(fields);
  }
}
