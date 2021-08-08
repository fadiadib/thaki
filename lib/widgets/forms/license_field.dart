import 'package:flutter/material.dart';

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