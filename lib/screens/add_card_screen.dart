import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkAddCardScreen extends StatefulWidget {
  static const String id = 'add_card_screen';

  TkAddCardScreen({this.editMode = false, this.card});
  final bool editMode;
  final TkCredit card;

  @override
  _TkAddCardScreenState createState() => _TkAddCardScreenState();
}

class _TkAddCardScreenState extends State<TkAddCardScreen>
    with TkFormFieldValidatorMixin {
  TkCredit _card;

  @override
  bool validateField(TkFormField field, dynamic value) {
    switch (field) {
      case TkFormField.cardHolder:
        return TkValidationHelper.validateNotEmpty(_card.holder);
      case TkFormField.cardNumber:
        return TkValidationHelper.validateCreditCard(_card.number);
      case TkFormField.cardExpiry:
        return TkValidationHelper.validateNotEmpty(_card.expiry);
      case TkFormField.cardCVV:
        return TkValidationHelper.validateNotEmpty(_card.cvv);
      default:
        return true;
    }
  }

  Widget _createForm(TkAccount account) {
    return Column(
      children: [
        // Holder name title and edit
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(
              title: S.of(context).kCardHolderName, uppercase: false),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkTextField(
            enabled: !account.isLoading,
            hintText: S.of(context).kCardHolderName,
            initialValue: _card?.holder,
            onChanged: (value) => setState(() => _card.holder = value),
            validator: getValidationCallback(TkFormField.cardHolder),
            validate: isValidating,
            errorMessage:
                S.of(context).kPleaseEnter + S.of(context).kCardHolderName,
          ),
        ),

        // Card number title and edit
        TkSectionTitle(title: S.of(context).kCardNumber, uppercase: false),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkTextField(
            enabled: !account.isLoading,
            hintText: S.of(context).kCardNumber,
            keyboardType: TextInputType.number,
            initialValue: TkCreditCardHelper.obscure(
                _card?.number,
                Provider.of<TkLangController>(context, listen: false)
                    .lang
                    .languageCode),
            onChanged: (value) => setState(() => _card.number = value),
            validator: getValidationCallback(TkFormField.cardNumber),
            validate: isValidating,
            errorMessage:
                S.of(context).kPleaseEnterAValid + S.of(context).kCardNumber,
          ),
        ),

        Row(
          children: [
            // Expiration date title and entry
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                      title: S.of(context).kCardExpiresYm, uppercase: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        30.0, 10.0, 5.0, 10.0),
                    child: TkTextField(
                      enabled: !account.isLoading,
                      hintText: S.of(context).kCardExpiresYm,
                      keyboardType: TextInputType.datetime,
                      initialValue: _card?.expiry,
                      onChanged: (value) =>
                          setState(() => _card.expiry = value),
                      validator: getValidationCallback(TkFormField.cardExpiry),
                      validate: isValidating,
                      errorMessage: S.of(context).kPleaseEnter +
                          S.of(context).kCardExpiry,
                    ),
                  ),
                ],
              ),
            ),

            // CVV title and entry
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                      title: S.of(context).kCardCVV,
                      uppercase: false,
                      start: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        5.0, 10.0, 30, 10.0),
                    child: TkTextField(
                      enabled: !account.isLoading,
                      hintText: S.of(context).kCardCVV,
                      keyboardType: TextInputType.number,
                      initialValue: _card?.cvv,
                      onChanged: (value) => setState(() => _card.cvv = value),
                      validator: getValidationCallback(TkFormField.cardCVV),
                      validate: isValidating,
                      errorMessage:
                          S.of(context).kPleaseEnter + S.of(context).kCardCVV,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        // Car default
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: TkFormBuilder.createCheckBox(
              label: S.of(context).kCarIsPreferred,
              value: _card?.preferred,
              onChanged: (value) => setState(() => _card.preferred = value)),
        ),
      ],
    );
  }

  Widget _createCCLogos() {
    List<Image> _icons = [];
    for (String image in kCCLogos) {
      _icons.add(Image.asset(image, height: 30));
    }

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _icons,
      ),
    );
  }

  Widget _createFormButton(TkAccount account) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TkButton(
        isLoading: account.isLoading,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        title: S.of(context).kSave,
        onPressed: () async {
          // Call API to add/update card
          setState(() => startValidating());

          if (validate()) {
            stopValidating();

            if (widget.editMode) {
              // Call API to add car
              if (await account.updateCard(_card)) {
                widget.card.copyValue(_card);
                Navigator.of(context).pop();
              }
            } else {
              // Call API to add car
              if (await account.addCard(_card)) Navigator.of(context).pop();
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.editMode) {
      _card = widget.card.createCopy();
    } else {
      _card = TkCredit.fromJson({});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(builder: (context, account, _) {
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
              _createForm(account),
              _createCCLogos(),
              _createFormButton(account),
              TkError(
                  message: widget.editMode
                      ? account.updateCardError
                      : account.addCardError),
            ],
          ),
        ),
      );
    });
  }
}
