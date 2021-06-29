import 'package:thaki/globals/index.dart';

class TkScreen {
  TkScreen.fromJson(Map<String, dynamic> json) {
    title = json[kScreenMessageTag];
    image = json[kScreenImageTag];
  }

  String title;
  String image;
}
