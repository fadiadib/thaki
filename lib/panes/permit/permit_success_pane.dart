import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/permitter.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/success_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPermitSuccessPane extends TkPane {
  TkPermitSuccessPane({onDone})
      : super(
            paneTitle: kResidentPermit, onDone: onDone, allowNavigation: false);

  Widget _getCloseButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TkButton(title: kClose, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPermitter>(
      builder: (context, permitter, _) {
        return permitter.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TkSectionTitle(title: kResidentPermit),
                  ),

                  // Result is dependent on the permitter result
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkSuccessCard(
                      message: permitter.applyError == null
                          ? kPermitSuccess
                          : permitter.applyError,
                      result: permitter.applyError == null,
                    ),
                  ),
                  _getCloseButton(),
                ],
              );
      },
    );
  }
}
