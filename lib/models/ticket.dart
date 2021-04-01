import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';

class TkTicket {
  TkTicket.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kTicketIdTag].toString());
    name = json[kTicketNameTag];
    start = DateTime.tryParse(json[kTicketStartTag]);
    duration = int.tryParse(json[kTicketDurationTag]) ?? 1;
    end = start.add(Duration(hours: duration));
    cancelled = json[kTicketCancelledTag] == true;
    showCode = json[kTicketShowCodeTag] == true;
    code = json[kTicketCodeTag];
    car = TkCar.fromJson(json);
  }

  int id;
  String name;
  TkCar car;
  DateTime start;
  DateTime end;
  int duration; // in hours
  bool cancelled;
  bool showCode;
  String code;
}
