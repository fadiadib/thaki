import 'package:thaki/globals/index.dart';

class TkState {
  TkState.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kStateIdTag].toString());
    nameEN = json[kStateEName];
    nameAR = json[kStateAName];
  }

  int id;
  String nameEN;
  String nameAR;
}
