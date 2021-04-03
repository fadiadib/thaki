import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/permitter.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/title_text_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPermitDisclaimerPane extends TkPane {
  TkPermitDisclaimerPane({onDone})
      : super(paneTitle: kResidentPermit, onDone: onDone);

  Widget _getAgreeButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 20.0),
      child: TkButton(title: kIAgree, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPermitter>(builder: (context, permitter, _) {
      return permitter.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TkSectionTitle(title: kResidentPermit),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TkTitleTextCard(
                    title: kApplyForResidentPermit,
                    message: permitter.disclaimer,
                    child: _getAgreeButton(),
                  ),
                ),
              ],
            );
    });
  }
}
