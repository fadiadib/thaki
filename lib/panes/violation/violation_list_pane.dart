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
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/violation_list.dart';

class TkViolationListPane extends TkPane {
  TkViolationListPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _getViolationList(TkPayer payer) {
    return TkViolationList(
        violations: payer.violations,
        selection: payer.selectedViolations,
        onTap: (TkViolation violation) => payer.toggleSelection(violation));
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
                    child:
                        TkSectionTitle(title: S.of(context).kCurrentViolations),
                  ),
                  _getViolationList(payer),
                  _getTotalFine(payer, context),
                  _getPaySelectionButton(payer, context),
                  TkError(message: payer.validationViolationsError),
                  TkError(message: payer.loadError)
                ],
              );
      },
    );
  }
}
