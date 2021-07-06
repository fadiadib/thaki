import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/success_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkTransactionSuccessPane extends TkPane {
  TkTransactionSuccessPane({onDone})
      : super(paneTitle: '', onDone: onDone, allowNavigation: false);

  Widget _getCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(title: S.of(context).kClose, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkTransactor>(
      builder: (context, transactor, _) {
        return transactor.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TkSectionTitle(title: ''),
                  ),

                  // Result is dependent on the payer result
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkSuccessCard(
                      message: transactor.transactionResult ?? false
                          ? S.of(context).kTransactionSuccess
                          : S.of(context).kTransactionFailure,
                      result: transactor.transactionResult,
                    ),
                  ),
                  _getCloseButton(context),
                ],
              );
      },
    );
  }
}
