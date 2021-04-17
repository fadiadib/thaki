import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/date_time_helper.dart';
import 'package:thaki/utilities/index.dart';
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
    this.langCode = 'en',
  });
  final TkTicket ticket;
  final Function onTap;
  final Function onDelete;
  final String ribbon;
  final Color ribbonColor;
  final String langCode;

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
              TkCardRibbon(
                  title: widget.ribbon,
                  color: widget.ribbonColor,
                  side: widget.langCode == 'en'
                      ? TkCardRibbonSide.right
                      : TkCardRibbonSide.left)
          ],
        ),
      ),
    );
  }

  void load(bool status) => setState(() => isLoading = status);

  @override
  Widget build(BuildContext context) {
    return TkSlidableTile(
      onDelete:
          widget.onDelete == null ? null : () => widget.onDelete(widget.ticket),
      child: GestureDetector(
        onTap: widget.onTap ??
            () => TkQRHelper.showQRCode(
                context: context, ticket: widget.ticket, loadCallback: load),
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
