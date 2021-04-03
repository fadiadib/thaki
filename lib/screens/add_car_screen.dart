import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/utilities/form_builder.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkAddCarScreen extends StatefulWidget {
  static const id = 'add_car_screen';

  @override
  _TkAddCarScreenState createState() => _TkAddCarScreenState();
}

class _TkAddCarScreenState extends State<TkAddCarScreen> {
  Widget _createForm() {
    return Column(
      children: [
        // Car nick name
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(title: kCarNickname, uppercase: false),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkTextField(hintText: kCarNickname),
        ),

        // Car state
        TkSectionTitle(title: kCarState, uppercase: false),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkTextField(hintText: kCarState),
        ),

        // Car license number
        TkSectionTitle(title: kCarLicensePlate, uppercase: false),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkTextField(hintText: kCarLicensePlate),
        ),

        Row(
          children: [
            // Make
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(title: kCarMake, uppercase: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        30.0, 10.0, 5.0, 10.0),
                    child: TkTextField(hintText: kCarMake),
                  ),
                ],
              ),
            ),

            // Model
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                      title: kCarModel, uppercase: false, start: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        5.0, 10.0, 30, 10.0),
                    child: TkTextField(hintText: kCarModel),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Car default
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: TkFormBuilder.createCheckBox(
              label: kCarIsPreferred, value: false, onChanged: (value) {}),
        ),
      ],
    );
  }

  Widget _createFormButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 0),
      child: TkButton(
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        title: kSave,
        onPressed: () async {
          // TODO: Call API to add car
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TkAppBar(
        context: context,
        enableNotifications: false,
        enableClose: true,
        removeLeading: false,
        title: TkLogoBox(),
      ),
      body: TkScaffoldBody(
        child: ListView(
          children: [
            _createForm(),
            _createFormButton(),
          ],
        ),
      ),
    );
  }
}
