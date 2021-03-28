import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/info_fields.dart';
import 'package:thaki/widgets/forms/text_fields.dart';

/// Utility that creates form widgets
class TkFormBuilder {
  static bool enableLabels = false;

  /// Creates the widget label
  static Widget createLabel({
    @required String label,
    EdgeInsets padding,
    bool noComma = false,
    bool forceLabel = false,
  }) {
    if (forceLabel || enableLabels)
      return Text(
        label,
        style: kRegularStyle[kSmallSize],
        textAlign: TextAlign.start,
      );
    return Container();
  }

  /// Create a drop down widget
  static Widget createDropDownField({
    @required BuildContext context,
    @required String label,
    @required String initialValue,
    @required Function onChanged,
    @required bool enabled,
    @required Function validator,
    @required bool isValidating,
    @required String errorMessage,
    @required List<TkInfoFieldValueOption> values,
  }) {
    // Convert values to strings
    List<String> stringValues = [];
    for (TkInfoFieldValueOption value in values) {
      stringValues.add(value.title);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        createLabel(label: label),
        TkDropDownField(
          context: context,
          value: initialValue,
          enabled: enabled,
          hintText: label,
          values: stringValues ?? [],
          onChanged: onChanged,
          validator: validator,
          validate: isValidating,
          errorMessage: errorMessage,
        ),
      ],
    );
  }

  /// Create a date, time or datetime widget
  static Widget createDateTimeField({
    @required BuildContext context,
    @required TkInfoFieldType type,
    @required String label,
    String initialValue,
    @required String value,
    @required Function onChanged,
    @required Function validator,
    @required bool isValidating,
    @required String errorMessage,
    @required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        createLabel(label: label),
        TkDateField(
          context: context,
          value: DateTime.tryParse(value.toString()),
          enabled: enabled,
          hintText: label,
          onChanged: onChanged,
          validator: validator,
          validate: isValidating,
          errorMessage: errorMessage,
          type: type,
        ),
      ],
    );
  }

  /// Create a text field
  static Widget createTextField({
    @required bool enabled,
    @required String label,
    @required String initialValue,
    @required TextInputType keyboardType,
    @required Function onChanged,
    @required Function validator,
    @required bool isValidating,
    @required String errorMessage,
    bool obscured = false,
    int lines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        createLabel(label: label),
        TkTextField(
          enabled: enabled,
          initialValue: initialValue,
          obscureText: obscured,
          keyboardType: keyboardType,
          hintText: label,
          onChanged: onChanged,
          validator: validator,
          validate: isValidating,
          errorMessage: errorMessage,
          lines: lines,
        ),
      ],
    );
  }

  /// Create a checkbox
  static Widget createCheckBox({
    @required String label,
    @required bool value,
    @required Function onChanged,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Theme(
          data: ThemeData(unselectedWidgetColor: kPrimaryColor),
          child: Checkbox(
            value: value ?? false,
            checkColor: kWhiteColor,
            activeColor: kSecondaryColor,
            onChanged: onChanged,
          ),
        ),
        createLabel(label: label, noComma: true, forceLabel: true),
      ],
    );
  }
}
