import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';

class TkTicket {
  TkTicket.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kTicketIdTag].toString());
    identifier = json[kTicketIdentifierTag] ?? '';
    start = DateTime.tryParse(json[kTicketStartTag].toString());
    duration = int.tryParse(json[kTicketDurationTag].toString());
    end = start.add(Duration(hours: duration));
    cancelled = json[kTicketCancelledTag].toString() == '1';
    showCodeTime = DateTime.tryParse(json[kTicketShowCodeTag].toString());
    code = json[kTicketCodeTag];
    car = TkCar.fromJson(json[kCarTag]);
  }

  void updateModel(Map<String, dynamic> json) {
    code = json[kTicketCodeTag];
  }

  int id;
  String identifier;
  TkCar car;
  DateTime start;
  DateTime end;
  DateTime showCodeTime;
  int duration; // in hours
  bool cancelled;
  String code;
}
