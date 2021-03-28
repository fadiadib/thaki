import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';

class TkTicket {
  TkTicket.fromJson(Map<String, dynamic> json) {
    car = TkCar.fromJson(json);
    start = DateTime.tryParse(json[kTicketStartTag]);
    end = DateTime.tryParse(json[kTicketEndTag]);
  }

  TkCar car;
  DateTime start;
  DateTime end;
}
