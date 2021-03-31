import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/permitter.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPermitFormPane extends TkPane {
  TkPermitFormPane({onDone})
      : super(paneTitle: kResidentPermit, onDone: onDone);

  Widget _createForm() {
    return TkFormFrame(
      formTitle: kResidentPermitFieldsJson[kFormName],
      actionTitle: kResidentPermitFieldsJson[kFormAction],
      buttonTag: kLoginTag,
      fields: TkInfoFieldsList.fromJson(data: kResidentPermitFieldsJson),
      action: (TkInfoFieldsList results) async {
        // TODO: save data into model
        onDone();
      },
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
                  padding: const EdgeInsets.only(top: 20.0, bottom: 0.0),
                  child: TkSectionTitle(title: kResidentPermit),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _createForm(),
                ),
              ],
            );
    });
  }
}
