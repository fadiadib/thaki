import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/attributes_controller.dart';
import 'package:thaki/providers/lang_controller.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
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
                    kQRIcon,
                    color: kPrimaryColor,
                    scale: 3,
                  ),
          ),
        ),

        // Ticket number
        if (widget.ticket.identifier != null && widget.ticket.id != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              children: [
                Text(
                  S.of(context).kTicketNumber,
                  style: kRegularStyle[kTinySize]
                      .copyWith(color: kMediumGreyColor),
                ),
                Text(
                  widget.ticket.identifier + widget.ticket.id.toString(),
                  style:
                      kBoldStyle[kTinySize].copyWith(color: kMediumGreyColor),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _getTileDetails(BuildContext context) {
    TkAttributesController attributesController =
        Provider.of<TkAttributesController>(context, listen: false);
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

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
                    Text(
                        widget.langCode == 'en'
                            ? widget.ticket.car.plateEN
                            : TkLicenseHelper.formatARLicensePlate(
                                widget.ticket.car.plateAR),
                        style: kBoldStyle[kNormalSize]),
                    if (attributesController.makeName(
                            widget.ticket.car.make, langController) !=
                        null)
                      Text(' - ' +
                          attributesController.makeName(
                              widget.ticket.car.make, langController)),
                  ],
                ),
                Text(
                  widget.ticket.duration.toString() +
                      ' ' +
                      (widget.ticket.duration == 1
                          ? S.of(context).kHour
                          : S.of(context).kHours),
                  style: kBoldStyle[kSmallSize],
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
        onTap: isLoading
            ? null
            : widget.onTap ??
                () => TkQRHelper.showQRCode(
                    context: context,
                    ticket: widget.ticket,
                    loadCallback: load),
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
