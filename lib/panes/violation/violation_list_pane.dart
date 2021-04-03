import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/violation_list.dart';

class TkViolationListPane extends TkPane {
  TkViolationListPane({onDone})
      : super(paneTitle: kPayViolations, onDone: onDone);

  Widget _getViolationList(TkPayer payer) {
    return TkViolationList(
        violations: payer.violations,
        selection: payer.selectedViolations,
        onTap: (TkViolation violation) => payer.toggleSelection(violation));
  }

  Widget _getTotalFine(TkPayer payer) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kTotal, style: kBoldStyle[kBigSize]),
          Text(
            kSAR + ' ' + payer.getSelectedViolationsFine().toString(),
            style: kBoldStyle[kBigSize],
          ),
        ],
      ),
    );
  }

  Widget _getPaySelectionButton(TkPayer payer) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        title: kPaySelected,
        onPressed: () {
          if (payer.validateViolations()) onDone();
        },
      ),
    );
  }

  Widget _getErrorMessage(TkPayer payer) {
    if (payer.validationViolationsError != null)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Text(
          payer.validationViolationsError,
          style: kErrorStyle,
          textAlign: TextAlign.center,
        ),
      );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPayer>(
      builder: (context, payer, _) {
        return payer.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TkSectionTitle(title: kCurrentViolations),
                  ),
                  _getViolationList(payer),
                  _getTotalFine(payer),
                  _getPaySelectionButton(payer),
                  _getErrorMessage(payer),
                ],
              );
      },
    );
  }
}
