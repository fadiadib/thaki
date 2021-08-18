import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/title_text_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPermitDisclaimerPane extends TkPane {
  TkPermitDisclaimerPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _getAgreeButton(BuildContext context) {
    return Padding(
      padding: kButtonPadding,
      child: TkButton(title: S.of(context).kIAgree, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkSubscriber>(builder: (context, subscriber, _) {
      String error = subscriber.error[TkSubscriberError.loadDisclaimer];
      return subscriber.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TkSectionTitle(title: S.of(context).kResidentPermit),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TkTitleTextCard(
                    title: S.of(context).kApplyForResidentPermit,
                    message: error == null
                        ? subscriber.disclaimer
                            .replaceAll('\\n', '\n')
                            .replaceAll('\\r', '\r')
                        : error,
                    messageColor: error == null ? null : kErrorTextColor,
                    child:
                        error != null ? Container() : _getAgreeButton(context),
                  ),
                ),
              ],
            );
    });
  }
}
