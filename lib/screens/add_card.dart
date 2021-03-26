import 'package:flutter/material.dart';

import 'package:thaki/globals/colors.dart';
import 'package:thaki/globals/images.dart';
import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/textfield.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkAddCardScreen extends StatefulWidget {
  static const String id = 'add_card_screen';

  @override
  _TkAddCardScreenState createState() => _TkAddCardScreenState();
}

class _TkAddCardScreenState extends State<TkAddCardScreen> {
  String _holderName;
  String _cardNumber;
  String _cardExpiry;
  String _ccv;

  Widget _createForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(title: 'Name', uppercase: false),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 30.0,
          ),
          child: TkTextField(
            hintText: 'Holder name',
          ),
        ),
        TkSectionTitle(title: 'Credit card number', uppercase: false),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 30.0,
          ),
          child: TkTextField(
            hintText: 'Credit card number',
            keyboardType: TextInputType.number,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(title: 'Expires', uppercase: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        30.0, 10.0, 5.0, 10.0),
                    child: TkTextField(
                      hintText: 'Expires',
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                    title: 'CVV',
                    uppercase: false,
                    start: false,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        5.0, 10.0, 30, 10.0),
                    child: TkTextField(
                      hintText: 'CVV',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _createCCLogos() {
    List<Image> _icons = [];
    for (String image in kCCLogos) {
      _icons.add(Image.asset(image));
    }

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _icons,
      ),
    );
  }

  Widget _createFormButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TkButton(
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        title: 'Save',
        onPressed: () async {
          // TODO: Call API to add card
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
            _createCCLogos(),
            _createFormButton(),
          ],
        ),
      ),
    );
  }
}
