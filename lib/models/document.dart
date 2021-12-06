import 'dart:io';

import 'package:thaki/globals/apiuris.dart';

class TkDocument {
  TkDocument.fromJson(Map<String, dynamic> json) {
    tag = json[kDocumentNameTag];
    title = json[kDocumentTitleTag];
    required = json[kDocumentRequiredTag] == true;
  }

  String? tag;
  String? title;
  bool? required;
  File? image;
}
