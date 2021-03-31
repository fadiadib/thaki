import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkViolationCarPane extends TkPane {
  TkViolationCarPane({onDone})
      : super(paneTitle: kPayViolations, onDone: onDone);

  Widget _createForm() {
    return Column(
      children: [
        // Car license number
        TkSectionTitle(title: kCarLicensePlate, uppercase: false),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkTextField(hintText: kCarLicensePlate),
        ),
      ],
    );
  }

  Widget _createFormButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 0),
      child: TkButton(
        title: kContinue,
        onPressed: onDone,
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
                    child: TkSectionTitle(
                      title: kEnterLRP,
                    ),
                  ),
                  _createForm(),
                  _createFormButton(),
                ],
              );
      },
    );
  }
}
