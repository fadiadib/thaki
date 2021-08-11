import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';

/// A widget that creates digits used for verifying one timer
/// passwords. It takes the number of digits of the OTP, the
/// required width of the widget and the gap size between widgets
/// the digit width is calculated based on the width and space
/// attributes. When the user edits one of the digits, focus is
/// shifted to the next digit. The widget has an onChaged property
/// which is a function with the entered code passed as an attribute
class TkLicenseField extends StatelessWidget {
  TkLicenseField({
    this.width = kDefaultOTPWidth,
    this.numDigits = 7,
    this.spaceWidth = 4,
    this.onChanged,
    this.finalFocusNode,
    this.enabled,
    this.validator,
    this.validate,
    this.errorMessage,
    this.values = const ['', ''],
    this.langCode = 'ar',
  });

  // Attributes
  final double width;
  final double spaceWidth;
  final int numDigits;
  final List<FocusNode> focusNodes = [];
  final List<String> values;
  final Function(String) onChanged;
  final FocusNode finalFocusNode;
  final bool enabled;
  final Function validator;
  final bool validate;
  final String errorMessage;
  final String langCode;

  List<TkTextField> getFields(BuildContext context) {
    // Add digits field
    TkTextField nWidget = TkTextField(
      // Adjust appearance
      width: 150,
      enabled: enabled,
      initialValue: values.length == 2 ? values[0] : null,

      // Adjust text appearance
      align: TextAlign.start,
      keyboardType: TextInputType.number,
      hintText: S.of(context).kDigits,

      // Callback
      onChanged: (String value) {
        // Set the value at the index to the updated string
        values[0] = value;

        if (onChanged != null) onChanged(values.join());
      },
    );

    // Add chars field
    TkTextField cWidget = TkTextField(
      // Adjust appearance
      width: 150,
      enabled: enabled,
      initialValue: values.length == 2 ? values[1] : null,

      // Adjust text appearance
      align: TextAlign.start,
      keyboardType: TextInputType.name,
      hintText: S.of(context).kCharacters,

      // Callback
      onChanged: (String value) {
        // Set the value at the index to the updated string
        values[1] = value;

        if (onChanged != null) {
          if (langCode == 'ar') onChanged(values.reversed.join());
          onChanged(values.join());
        }
      },
    );

    if (langCode == 'ar') return [cWidget, nWidget];
    // Return the widgets to the caller Row
    return [nWidget, cWidget];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // Build a row with the OTP digits (evenly spaced)
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getFields(context),
        ),
        if (validate && (values == null || !validator()))
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(errorMessage, style: kErrorStyle),
          )
      ],
    );
  }
}


class TkLicenseField2 extends StatefulWidget {
  TkLicenseField2({
    this.widthPercentage = 0.4,
    this.characterLength = 3,
    this.digitsLength = 4,
    this.onChanged,
    this.validator,
    this.validate,
    this.errorMessage,
    this.values = const ['', ''],
    this.langCode = 'ar',
  });

  // Attributes
  final double widthPercentage;
  final int characterLength;
  final int digitsLength;
  final List<String> values;
  final Function(String) onChanged;
  final Function validator;
  final bool validate;
  final String errorMessage;
  final String langCode;
  @override
  _TkLicenseField2State createState() => _TkLicenseField2State();
}

class _TkLicenseField2State extends State<TkLicenseField2> {
  FocusNode _charNode = FocusNode(), _digitNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _charNode.requestFocus();
      Future.delayed(Duration(milliseconds: 1),(){
        _digitNode.requestFocus();
      }).then((value){
        Future.delayed(Duration(milliseconds: 1),(){
          _digitNode.unfocus();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // Build a row with the OTP digits
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: getFields(context),
        ),
        if (widget.validate && (widget.values == null || !widget.validator()))
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(widget.errorMessage, style: kErrorStyle),
          )
      ],
    );
  }

  List<Widget> getFields(BuildContext context) {
    // Add digits field
    Widget nWidget = SizedBox(
      width: MediaQuery.of(context).size.width * widget.widthPercentage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).kDigits),
          SizedBox(height: 10.0,),
          PinCodeTextField(
            controller: widget.values[0] != null ? TextEditingController(text: widget.values[0].replaceAll(' ', '')) : null,
            focusNode: _digitNode,
            autoDismissKeyboard: false,
            appContext: context,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              activeColor: kSecondaryColor, //123456
              selectedColor: kPrimaryColor,
              inactiveColor: kAccentGreyColor,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              fieldWidth: 35,
              activeFillColor: Colors.transparent,
            ),
            beforeTextPaste: (text) => true,
            dialogConfig: DialogConfig(
              affirmativeText: S.of(context).kOk,
              negativeText: S.of(context).kCancel,
              dialogContent: S.of(context).kConfirmPasteDetails,
              dialogTitle: S.of(context).kConfirmPaste,
            ),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: false,
            length: widget.digitsLength,

            // Callback
            onChanged: (String value) {
              // Set the value at the index to the updated string
              widget.values[0] = value;

              if (widget.onChanged != null) widget.onChanged(widget.values.join());
            },
          ),
        ],
      ),
    );

    // Add chars field
    Widget cWidget = SizedBox(
      width: MediaQuery.of(context).size.width * widget.widthPercentage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).kCharacters,),
          SizedBox(height: 10.0,),
          PinCodeTextField(
            controller: widget.values[1] != null ? TextEditingController(text: widget.values[1].replaceAll(' ', '')) : null,
            focusNode: _charNode,
            autoDismissKeyboard: false,
            appContext: context,
            keyboardType: TextInputType.name,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              activeColor: kSecondaryColor, //123456
              selectedColor: kPrimaryColor,
              inactiveColor: kAccentGreyColor,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              fieldWidth: 35,
              activeFillColor: Colors.transparent,
            ),
            beforeTextPaste: (text) => true,
            dialogConfig: DialogConfig(
              affirmativeText: S.of(context).kOk,
              negativeText: S.of(context).kCancel,
              dialogContent: S.of(context).kConfirmPasteDetails,
              dialogTitle: S.of(context).kConfirmPaste,
            ),
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            enableActiveFill: false,
            length: widget.characterLength,

            // Callback
            onChanged: (String value) {
              // Set the value at the index to the updated string
              widget.values[1] = value;

              if (widget.onChanged != null) {
                if (widget.langCode == 'ar') widget.onChanged(widget.values.reversed.join());
                widget.onChanged(widget.values.join());
              }
            },
          ),
        ],
      ),
    );

    if (widget.langCode == 'ar') return [cWidget, nWidget];
    // Return the widgets to the caller Row
    return [nWidget, cWidget];
  }
}

