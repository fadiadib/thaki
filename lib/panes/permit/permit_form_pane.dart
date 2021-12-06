import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPermitFormPane extends TkPane {
  TkPermitFormPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _createForm(BuildContext context, TkSubscriber subscriber) {
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang!.languageCode,
      formTitle: kResidentPermitFieldsJson[kFormName]
          [controller.lang!.languageCode],
      actionTitle: kResidentPermitFieldsJson[kFormAction]
          [controller.lang!.languageCode],
      buttonTag: kLoginTag,
      fields: account.user!.toInfoFields(
          TkInfoFieldsList.fromJson(data: kResidentPermitFieldsJson)),
      action: (TkInfoFieldsList results) async {
        // Save data into model
        // TODO: It is better to first move the data from the user model to
        // TODO: a permit model and then update the info fields from the permit
        subscriber.permit = TkPermit.fromInfoFields(results);

        onDone!();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkSubscriber>(builder: (context, subscriber, _) {
      return subscriber.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
                  child: TkSectionTitle(title: S.of(context).kResidentPermit),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _createForm(context, subscriber),
                ),
              ],
            );
    });
  }
}
