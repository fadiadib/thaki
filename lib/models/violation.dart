import 'package:thaki/globals/index.dart';

class TkViolation {
  TkViolation.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kViolationIdTag].toString());
    name = json[kViolationNameTag].toString();
    dateTime = DateTime.tryParse(json[kViolationDateTimeTag].toString());
    location = json[kViolationLocationTag].toString();
    fine = double.tryParse(json[kViolationFineTag].toString());
    carPlate = json[kViolationCarTag];
    issueNumber = int.tryParse(json[kViolationIssueTag].toString());
  }

  int id;
  String name;
  DateTime dateTime;
  String location;
  double fine;
  String carPlate;
  int issueNumber;
}
