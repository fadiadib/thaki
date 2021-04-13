import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/utilities/date_time_helper.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/ribbon.dart';
import 'package:thaki/widgets/general/sliddable.dart';

class TkTicketTile extends StatefulWidget {
  TkTicketTile({
    @required this.ticket,
    this.onTap,
    this.onDelete,
    this.ribbon,
    this.ribbonColor,
  });
  final TkTicket ticket;
  final Function onTap;
  final Function onDelete;
  final String ribbon;
  final Color ribbonColor;

  @override
  _TkTicketTileState createState() => _TkTicketTileState();
}

class _TkTicketTileState extends State<TkTicketTile> {
  bool isLoading = false;

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
        child: isLoading
            ? TkProgressIndicator()
            : Image.asset(
                kPackageIcon,
                color: kPrimaryColor,
              ),
      ),
    );
  }

  Widget _getTileDetails(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.ticket.car.plateEN,
                        style: kBoldStyle[kNormalSize]),
                    Text(' - ' + widget.ticket.car.make + ' '),
                    Text(widget.ticket.car.model)
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
                                widget.ticket.start.toString()),
                            style: kBoldStyle[kSmallSize]
                                .copyWith(color: kLightPurpleColor),
                          ),
                          Text(
                            TkDateTimeHelper.formatTime(
                                context, widget.ticket.start.toString()),
                            style: kBoldStyle[kNormalSize]
                                .copyWith(color: kBlackColor),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            TkDateTimeHelper.formatDate(
                                widget.ticket.end.toString()),
                            style: kBoldStyle[kSmallSize]
                                .copyWith(color: kLightPurpleColor),
                          ),
                          Text(
                            TkDateTimeHelper.formatTime(
                                context, widget.ticket.end.toString()),
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
            if (widget.ribbon != null)
              TkCardRibbon(title: widget.ribbon, color: widget.ribbonColor)
          ],
        ),
      ),
    );
  }

  void openCode(BuildContext context) async {
    TkBooker booker = Provider.of<TkBooker>(context, listen: false);
    if (widget.ticket.cancelled == false) {
      booker.loadQRError = null;

      if (widget.ticket.code == null) {
        setState(() => isLoading = true);
        await booker.loadQR(
            Provider.of<TkAccount>(context, listen: false).user, widget.ticket);
        setState(() => isLoading = false);
      }

      TkDialogHelper.gOpenDrawer(
        context: context,
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: kWhiteBgLinearGradient,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: booker.loadQRError == null
                    ? widget.ticket.code != null
                        ? Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: kFormBgColor,
                              boxShadow: kTileShadow,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: QrImage(
                              data: widget.ticket.code,
                              version: QrVersions.auto,
                              size: 380.0,
                            ),
                          )
                        : TkError(message: kUnknownError)
                    : TkError(message: booker.loadQRError),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TkSlidableTile(
      onDelete:
          widget.onDelete == null ? null : () => widget.onDelete(widget.ticket),
      child: GestureDetector(
        onTap: widget.onTap ?? () => openCode(context),
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
              _getTileDetails(context),
            ],
          ),
        ),
      ),
    );
  }
}
