import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';

/// A widget that creates digits used for verifying one timer
/// passwords. It takes the number of digits of the OTP, the
/// required width of the widget and the gap size between widgets
/// the digit width is calculated based on the width and space
/// attributes. When the user edits one of the digits, focus is
/// shifted to the next digit. The widget has an onChaged property
/// which is a function with the entered code passed as an attribute

class TkOTPField2 extends StatelessWidget {
  TkOTPField2({
    this.width = kDefaultOTPWidth,
    this.numDigits = kOTPDigits,
    this.spaceWidth = kDefaultOTPGapSize,
    this.onChanged,
    this.finalFocusNode,
    this.enabled,
    this.validator,
    this.values = const [],
    this.validate,
    this.errorMessage,
    this.context,
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
  final BuildContext context;

  Widget getDigitsField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        autoFocus: true,
        length: numDigits,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          activeColor: kSecondaryColor, //123456
          selectedColor: kPrimaryColor,
          inactiveColor: kAccentGreyColor,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.transparent,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: false,
        // errorAnimationController: errorController,
        // controller: textEditingController,
        onCompleted: onChanged,
        onChanged: onChanged,
        beforeTextPaste: (text) => true,
        dialogConfig: DialogConfig(
          affirmativeText: S.of(context).kOk,
          negativeText: S.of(context).kCancel,
          dialogContent: S.of(context).kConfirmPasteDetails,
          dialogTitle: S.of(context).kConfirmPaste,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getDigitsField(),
        if (validate && (values == null || !validator()))
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(errorMessage, style: kErrorStyle),
          )
      ],
    );
  }
}
