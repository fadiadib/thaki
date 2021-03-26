import 'package:thaki/globals/apiuris.dart';
import 'package:thaki/models/car.dart';
import 'package:thaki/models/credit.dart';

class TkUser {
  TkUser.fromJson(Map<String, dynamic> json) {
    token = json[kUserTokenTag];
    name = json[kUserNameTag];
    email = json[kUserEmailTag];
    phone = json[kUserPhoneTag];

    // Create user cars
    cars = [];
    if (json[kUserCarsTag] != null)
      for (Map<String, dynamic> carJson in json[kUserCarsTag])
        cars.add(TkCar.fromJson(carJson));

    // Create user credit cards
    cards = [];
    if (json[kUserCardsTag] != null)
      for (Map<String, dynamic> cardJson in json[kUserCardsTag])
        cards.add(TkCredit.fromJson(cardJson));
  }

  String token;
  String name;
  String email;
  String phone;
  List<TkCar> cars;
  List<TkCredit> cards;
}
