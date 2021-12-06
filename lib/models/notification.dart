import 'dart:math';

import 'package:thaki/globals/index.dart';

class TkNotification {
  TkNotification.fromJson(Map<String, dynamic> json, {int? nid, String? tag}) {
    // Notification data can be inside a 'data'
    // ag or 'notification' tag
    Map<dynamic, dynamic>? dataJson = json;
    if (json[kNotificationDataTag] != null) {
      dataJson = json[kNotificationDataTag];
    } else if (json[kNotificationTag] != null) {
      dataJson = json;
    }

    // Get the id
    id = int.tryParse(dataJson![kNotificationIdTag].toString());
    // if (id == null)
    //   id = int.tryParse(
    //       dataJson[kNotificationTagTag].toString().split('_').last);
    if (id == null) id = Random().nextInt(10000);
    this.nid = nid ?? int.tryParse(dataJson[kNotificationNIdTag].toString());
    this.tag = tag ?? dataJson[kNotificationTagTag];

    // Get message details: title, short and body
    title = dataJson[kNotificationTitleTag] ?? '';
    short = dataJson[kNotificationMessageTag] ?? '';
    body = dataJson[kNotificationBodyTag] ?? '';

    // Additional data: Type and details
    dataType = dataJson[kNotificationDataTypeTag];
    dataDetail = dataJson[kNotificationDataDetailTag];

    // Get expiry date
    if (dataJson[kNotificationExpiryTag] != null)
      expiry = DateTime.tryParse(dataJson[kNotificationExpiryTag].toString());

    // isSeen flag (this is an internal variable
    // that doesn't come from the backend)
    isSeen = json[kNotificationSeenTag] ?? false;

    // Date received (this is an internal variable
    // that doesn't come from the backend)
    if (json[kNotificationDateTag] != null)
      date = DateTime.tryParse(json[kNotificationDateTag].toString());
    else
      date = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      kNotificationIdTag: id.toString(),
      kNotificationNIdTag: nid?.toString(),
      kNotificationTagTag: tag,
      kNotificationTitleTag: title,
      kNotificationMessageTag: short,
      kNotificationBodyTag: body,
      kNotificationDataDetailTag: dataDetail,
      kNotificationDataTypeTag: dataType,
      kNotificationSeenTag: isSeen,
      kNotificationExpiryTag: expiry.toString(),
      kNotificationDateTag: date.toString(),
    };
  }

  int? id;
  int? nid;
  String? tag;
  String? title;
  String? short;
  String? body;
  String? dataDetail;
  String? dataType;
  bool? isSeen;
  bool showBody = false;
  DateTime? expiry;
  DateTime? date;
}
