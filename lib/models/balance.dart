import 'package:thaki/globals/index.dart';

class TkBalance {
  TkBalance.fromJson(Map<String, dynamic> json) {
    for (Map<String, dynamic> package in json[kClientPackages]) {
      points += int.tryParse(package['remaining_hours'].toString())!;

      DateTime endDate = DateTime.tryParse(package['end_date'].toString())!;
      if (validity.isBefore(endDate)) validity = endDate;
    }
  }

  void updateFromJson(Map<String, dynamic> json) {
    points += int.tryParse(json[kClientPackage]['remaining_hours'].toString())!;

    DateTime endDate =
        DateTime.tryParse(json[kClientPackage]['end_date'].toString())!;
    if (validity.isBefore(endDate)) validity = endDate;
  }

  int points = 0;
  DateTime validity = DateTime.now();
}
