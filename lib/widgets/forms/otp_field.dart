import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/forms/text_fields.dart';

/// A widget that creates digits used for verifying one timer
/// passwords. It takes the number of digits of the OTP, the
/// required width of the widget and the gap size between widgets
/// the digit width is calculated based on the width and space
/// attributes. When the user edits one of the digits, focus is
/// shifted to the next digit. The widget has an onChaged property
/// which is a function with the entered code passed as an attribute
class TkOTPField extends StatelessWidget {
  TkOTPField({
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

  List<TkTextField> getDigitsFields() {
    List<TkTextField> widgets = [];
    double digitWidth = (width - spaceWidth * (numDigits - 1)) / numDigits;

    // Loop on all digits and create a widget for each
    for (int i = 0; i < numDigits; i++) {
      // Create a focus node that will be
      // associated with tis widget
      FocusNode node = new FocusNode();
      focusNodes.add(node);

      // Initialize the digit value to 0
      if (values.length < numDigits) values.add('0');

      // Create a BfTextField widget for the digit
      widgets.add(
        TkTextField(
          // Set focus node and auto focus
          focusNode: node,
          autoFocus: i == 0 ? true : false,
          showCursor: false,

          // Adjust appearance
          raised: true,
          width: digitWidth,
          borderRadius: kDefaultOTPBorderRadius,
          internalHPadding: 0.0,
          internalVPadding: 0.0,
          enabled: enabled,

          // Adjust text appearance
          align: TextAlign.center,
          keyboardType: TextInputType.number,
          style: kOTPEditStyle,

          // Callback
          onChanged: (value) {
            // Remove focus from the widget and
            // jump to the next
            // focusNodes[i].unfocus();

            // if i is smaller than digits, that means
            // that this is the last digit so remove focus
            if (i < numDigits - 1) {
              focusNodes[i + 1].requestFocus();
            } else if (i == numDigits - 1) {
              if (finalFocusNode != null) finalFocusNode.requestFocus();
            }

            // Set the value at the index to the updated string
            values[i] = value;

            if (onChanged != null) onChanged(values.join());
          },
        ),
      );
    }

    // Return the widgets to the caller Row
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // Build a row with the OTP digits (evenly spaced)
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getDigitsFields(),
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
