import 'package:thaki/globals/index.dart';

class TkBalance {
  TkBalance.fromJson(Map<String, dynamic> json) {
    points = json[kBalancePointsTag];
    validity = DateTime.tryParse(json[kBalanceValidityTag]);
  }

  int points;
  DateTime validity;
}
