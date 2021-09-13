import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/tabs.dart';
import 'package:thaki/widgets/lists/violation_list.dart';

class TkViolationListPane extends TkPane {
  TkViolationListPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _getUnpaidViolationList(TkPayer payer) {
    return TkViolationList(
      violations: payer.violations,
      selection: payer.selectedViolations,
      onTap: (TkViolation violation) {
        // Only allow selection of unpaid violations
        if (violation.isUnpaid) payer.toggleSelection(violation);
      },
    );
  }

  Widget _getTotalFine(TkPayer payer, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(S.of(context).kTotal, style: kBoldStyle[kBigSize]),
          Text(
            S.of(context).kSAR +
                ' ' +
                payer.getSelectedViolationsFine().toString(),
            style: kBoldStyle[kBigSize],
          ),
        ],
      ),
    );
  }

  Widget _getPaySelectionButton(TkPayer payer, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        title: (payer.violations != null && payer.violations.isNotEmpty)
            ? S.of(context).kPaySelected
            : S.of(context).kClose,
        onPressed: () {
          if ((payer.violations == null || payer.violations.isEmpty))
            Navigator.of(context).pop();
          else {
            if (payer.validateViolations(context)) onDone();
          }
        },
      ),
    );
  }

  Widget _buildUnpaidViolationsPane(BuildContext context, TkPayer payer) {
    return ListView(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0),
        //   child: TkSectionTitle(title: S.of(context).kCurrentViolations),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: _getUnpaidViolationList(payer),
        ),
        _getTotalFine(payer, context),
        _getPaySelectionButton(payer, context),
        TkError(message: payer.validationViolationsError),
        TkError(message: payer.loadError)
      ],
    );
  }

  Widget _buildPaidViolationsPane(BuildContext context, TkPayer payer) {
    return ListView(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0),
        //   child: TkSectionTitle(title: S.of(context).kPaidViolations),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkViolationList(violations: payer.paidViolations),
        ),
        TkError(message: payer.loadError)
      ],
    );
  }

  Widget _buildCancelledViolationsPane(BuildContext context, TkPayer payer) {
    return ListView(
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 20.0),
        //   child: TkSectionTitle(title: S.of(context).kPaidViolations),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkViolationList(violations: payer.cancelledViolations),
        ),
        TkError(message: payer.loadError)
      ],
    );
  }

  Widget _buildTabs(BuildContext context, TkPayer payer) {
    return TkTabs(
      length: 3,
      titles: [
        S.of(context).kCurrent.toUpperCase(),
        S.of(context).kPaid.toUpperCase(),
        S.of(context).kCancelled.toUpperCase()
      ],
      children: [
        _buildUnpaidViolationsPane(context, payer),
        _buildPaidViolationsPane(context, payer),
        _buildCancelledViolationsPane(context, payer),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPayer>(
      builder: (context, payer, _) {
        return payer.isLoading
            ? TkProgressIndicator()
            : _buildTabs(context, payer);
      },
    );
  }
}
