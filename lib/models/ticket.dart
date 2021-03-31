import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';

class TkTicket {
  TkTicket.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kTicketIdTag].toString());
    name = json[kTicketNameTag];
    start = DateTime.tryParse(json[kTicketStartTag]);
    end = DateTime.tryParse(json[kTicketEndTag]);
    car = TkCar.fromJson(json);
  }

  int id;
  String name;
  TkCar car;
  DateTime start;
  DateTime end;
}
