import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/date_time_helper.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/general/sliddable.dart';

class TkTicketTile extends StatelessWidget {
  TkTicketTile({@required this.ticket, this.onTap});
  final TkTicket ticket;
  final Function onTap;

  Widget _getTileImage() {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.asset(
          kPackageIcon,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _getTileDetails() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ticket.name,
                    style:
                        kBoldStyle[kNormalSize].copyWith(color: kPrimaryColor)),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(ticket.car.licensePlate,
                        style: kBoldStyle[kNormalSize]),
                    Text(' - ' + ticket.car.make + ' '),
                    Text(ticket.car.model)
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            TkDateTimeHelper.formatDate(
                                ticket.start.toString()),
                            style: kBoldStyle[kSmallSize]
                                .copyWith(color: kLightPurpleColor),
                          ),
                          Text(
                            TkDateTimeHelper.formatTime(
                                ticket.start.toString()),
                            style: kBoldStyle[kNormalSize]
                                .copyWith(color: kBlackColor),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            TkDateTimeHelper.formatDate(ticket.end.toString()),
                            style: kBoldStyle[kSmallSize]
                                .copyWith(color: kLightPurpleColor),
                          ),
                          Text(
                            TkDateTimeHelper.formatTime(ticket.end.toString()),
                            style: kBoldStyle[kNormalSize]
                                .copyWith(color: kBlackColor),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openCode(BuildContext context) {
    if (ticket.showCode) {
      TkDialogHelper.gOpenDrawer(
          context: context,
          drawer: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: QrImage(
                    data: ticket.code,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TkSlidableTile(
      child: GestureDetector(
        onTap: onTap ?? () => openCode(context),
        child: Container(
          decoration: BoxDecoration(
            color: kTileBgColor,
            boxShadow: kTileShadow,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _getTileImage(),
              Container(
                width: 1,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: kMediumGreyColor.withOpacity(0.2)),
                ),
              ),
              _getTileDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
