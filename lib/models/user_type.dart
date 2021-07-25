import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

class TkUserType extends TkAttribute {
  TkUserType.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kAttributeIdTag].toString());
    nameEN = json[kAttributeENameTag];
    nameAR = json[kAttributeANameTag];
  }
}
