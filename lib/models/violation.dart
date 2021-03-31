import 'package:thaki/globals/index.dart';

class TkViolation {
  TkViolation.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kViolationIdTag].toString());
    description = json[kViolationDescTag].toString();
    dateTime = DateTime.tryParse(json[kViolationDateTimeTag].toString());
    location = json[kViolationLocationTag].toString();
    fine = double.tryParse(json[kViolationFineTag].toString());
  }

  int id;
  String description;
  DateTime dateTime;
  String location;
  double fine;
}
