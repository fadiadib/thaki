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
    if (json[kViolationStatusTag] != null)
      status = int.tryParse(json[kViolationStatusTag].toString()) ?? 0;
  }

  bool get isUnpaid => status == 0;
  bool get isPaid => status == 1;
  bool get isCancelled => status == 2;

  int? id;
  String? name;
  DateTime? dateTime;
  late String location;
  double? fine;
  String? carPlate;
  int? issueNumber;
  int status = 0;
}
