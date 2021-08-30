import 'package:thaki/globals/apiuris.dart';
import 'package:thaki/models/index.dart';

class TkTransaction {
  TkTransaction();
  TkTransaction.fromJson(Map json) {
    id = int.tryParse(json[kIdTag].toString());
    amount = double.tryParse(json[kAmountTag].toString());
    status = int.tryParse(json[kStatusTag].toString());
    created = DateTime.tryParse(json[kCreatedAtTag].toString());
  }

  int id;
  double amount;
  int status;
  DateTime created;
}

class TkPackageTransaction extends TkTransaction {
  TkPackageTransaction.fromJson(Map json) {
    id = int.tryParse(json[kIdTag].toString());
    amount = double.tryParse(json[kAmountTag].toString());
    status = int.tryParse(json[kStatusTag].toString());
    created = DateTime.tryParse(json[kCreatedAtTag].toString());

    packageId = int.tryParse(json[kPackagePkgIdTag].toString());
    name = json[kPackageNameTag];
    description = json[kPackageDetailsTag];
    price = int.tryParse(json[kPackagePriceTag].toString());
    hours = int.tryParse(json[kUserPackagePoints].toString());
  }

  int packageId;
  String name;
  String description;
  int price;
  int hours;
}

class TkSubscriptionTransaction extends TkTransaction {
  TkSubscriptionTransaction.fromJson(Map json) {
    id = int.tryParse(json[kIdTag].toString());
    amount = double.tryParse(json[kAmountTag].toString());
    status = int.tryParse(json[kStatusTag].toString());
    created = DateTime.tryParse(json[kCreatedAtTag].toString());

    subscriptionId = int.tryParse(json[kSubscriptionIdIdTag].toString());
    name = json[kSubscriptionNameTag];
    price = int.tryParse(json[kSubscriptionPriceTag].toString());
    period = int.tryParse(json[kSubscriptionPeriodTag].toString());
  }

  int subscriptionId;
  String name;
  int price;
  int period;
}

class TkViolationTransaction extends TkTransaction {
  TkViolationTransaction.fromJson(Map json) {
    id = int.tryParse(json[kIdTag].toString());
    amount = double.tryParse(json[kAmountTag].toString());
    status = int.tryParse(json[kStatusTag].toString());
    created = DateTime.tryParse(json[kCreatedAtTag].toString());

    violations.clear();
    for (Map violationJson in json[kViolationsDetailsTag])
      violations.add(TkViolation.fromJson(violationJson));
  }

  List<TkViolation> violations = [];
}
