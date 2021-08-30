import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkTransactionTile extends StatefulWidget {
  TkTransactionTile({this.transaction});

  final TkTransaction transaction;

  @override
  _TkTransactionTileState createState() => _TkTransactionTileState();
}

class _TkTransactionTileState extends State<TkTransactionTile> {
  bool _isExpanded = false;

  Widget _getTileImage() {
    Color color = widget.transaction is TkPackageTransaction
        ? kSecondaryColor
        : widget.transaction is TkSubscriptionTransaction
            ? kGreenAccentColor
            : kTertiaryColor;

    return Container(
      height: 50,
      width: 120,
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Center(
          child: Text(
            S.of(context).kSAR + ' ' + widget.transaction.amount.toString(),
            style: kBoldStyle[kNormalSize].copyWith(color: color),
          ),
        ),
      ),
    );
  }

  Widget _getTileTitle() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  TkDateTimeHelper.formatDate(
                      widget.transaction.created.toString()),
                  style:
                      kBoldStyle[kSmallSize].copyWith(color: kMediumGreyColor),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 4.0),
                  child: Text(
                    TkDateTimeHelper.formatTime(
                        context, widget.transaction.created.toString()),
                    style: kRegularStyle[kSmallSize]
                        .copyWith(color: kMediumGreyColor),
                  ),
                ),
              ],
            ),
            Text(
              widget.transaction is TkPackageTransaction
                  ? S.of(context).kPackage
                  : widget.transaction is TkSubscriptionTransaction
                      ? S.of(context).kSubscription
                      : _getFirstViolationTitle(),
              style:
                  kRegularStyle[kSmallSize].copyWith(color: kMediumGreyColor),
            ),
          ],
        ),
      ),
    );
  }

  String _getFirstViolationTitle() {
    String result = S.of(context).kViolations;
    if (widget.transaction is TkViolationTransaction) {
      final TkViolationTransaction violationTransaction = widget.transaction;

      if (violationTransaction.violations.isNotEmpty)
        result = violationTransaction.violations.first.name;
    }
    return result;
  }

  Widget _getTileDetails() {
    if (widget.transaction is TkPackageTransaction) {
      final TkPackageTransaction packageTransaction = widget.transaction;
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              packageTransaction.name,
              style: kBoldStyle[kSmallSize].copyWith(color: kMediumGreyColor),
            ),
            Text(
              packageTransaction.description,
              style:
                  kRegularStyle[kSmallSize].copyWith(color: kMediumGreyColor),
            ),
          ],
        ),
      );
    } else if (widget.transaction is TkSubscriptionTransaction) {
      final TkSubscriptionTransaction subscriptionTransaction =
          widget.transaction;
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subscriptionTransaction.name,
              style: kBoldStyle[kSmallSize].copyWith(color: kMediumGreyColor),
            ),
            Text(
              S.of(context).kValidFor +
                  ': ' +
                  subscriptionTransaction.period.toString() +
                  ' ' +
                  S.of(context).kDays,
              style:
                  kRegularStyle[kSmallSize].copyWith(color: kMediumGreyColor),
            ),
          ],
        ),
      );
    } else if (widget.transaction is TkViolationTransaction) {
      final TkViolationTransaction violationTransaction = widget.transaction;

      List<Widget> widgets = [];
      for (TkViolation violation in violationTransaction.violations) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      violation.issueNumber.toString(),
                      style: kBoldStyle[kSmallSize]
                          .copyWith(color: kMediumGreyColor),
                    ),
                    SizedBox(width: 5),
                    Text(
                      violation.carPlate,
                      style: kRegularStyle[kSmallSize]
                          .copyWith(color: kMediumGreyColor),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(violation.name,
                      style: kBoldStyle[kSmallSize]
                          .copyWith(color: kMediumGreyColor)),
                ),
                Text(
                  TkDateTimeHelper.formatDate(violation.dateTime.toString()) +
                      ' ' +
                      TkDateTimeHelper.formatTime(
                          context, violation.dateTime.toString()),
                  style: kRegularStyle[kSmallSize]
                      .copyWith(color: kMediumGreyColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    violation.location,
                    style: kBoldStyle[kSmallSize]
                        .copyWith(color: kMediumGreyColor),
                  ),
                ),
                // Text(
                //   S.of(context).kSAR + ' ' + violation.fine.toString(),
                //   style: kRegularStyle[kSmallSize]
                //       .copyWith(color: kMediumGreyColor),
                // )
              ],
            ),
          ),
        );
      }
      return Column(children: widgets);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kTileBgColor,
              boxShadow: kSmallTileShadow,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _getTileImage(),
                Container(
                  width: 1,
                  height: 50,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: kMediumGreyColor.withOpacity(0.2)),
                  ),
                ),
                _getTileTitle(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    _isExpanded ? kCollapseBtnIcon : kExpandBtnIcon,
                    color: kMediumGreyColor.withOpacity(0.6),
                    size: 18,
                  ),
                )
              ],
            ),
          ),
          if (_isExpanded) _getTileDetails()
        ],
      ),
    );
  }
}
