import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

class TkColor extends TkAttribute {
  TkColor.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kAttributeIdTag].toString());
    nameEN = json[kAttributeENameTag];
    nameAR = json[kAttributeANameTag];
    colorHEX = json[kColorHexTag];
  }

  String? colorHEX;
}
