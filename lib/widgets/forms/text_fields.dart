import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/info_fields.dart';
import 'package:thaki/utilities/date_time_helper.dart';
import 'package:thaki/widgets/forms/dropdown_field.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';

/// Text field widget
class TkTextField extends StatelessWidget {
  TkTextField({
    this.icon,
    this.initialValue,
    this.onChanged,
    this.keyboardType,
    this.hintText,
    this.validator,
    this.errorMessage,
    this.focusNode,
    this.isLoading = false,
    this.enabled = true,
    this.obscureText = false,
    this.halfSize = false,
    this.validate = false,
    this.borderRadius = kDefaultTextEditRadius,
    this.width,
    this.height = kDefaultTextEditHeight,
    this.internalHPadding = kDefaultTextEditInternalPadding,
    this.internalVPadding = kDefaultTextEditInternalPadding,
    this.raised = false,
    this.align = TextAlign.start,
    this.autoFocus = false,
    this.style,
    this.showCursor = true,
    this.controller,
    this.lines = 1,
  });

  final IconData icon;
  final String initialValue;
  final bool isLoading;
  final bool enabled;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final bool halfSize;
  final Function validator;
  final bool validate;
  final String errorMessage;
  final double width;
  final double height;
  final double borderRadius;
  final double internalHPadding;
  final double internalVPadding;
  final bool raised;
  final TextAlign align;
  final FocusNode focusNode;
  final bool autoFocus;
  final TextStyle style;
  final bool showCursor;
  final int lines;
  final TextEditingController controller;

  Widget getField() {
    return TextFormField(
      // Text settings
      autocorrect: false,
      enabled: enabled,
      obscureText: obscureText,
      textAlign: align,
      style: enabled ? style ?? kTextEditStyle : kDisabledTextEditStyle,
      initialValue: initialValue,
      controller: controller,

      // Keyboard settings
      keyboardType: lines > 1 ? TextInputType.multiline : keyboardType,
      inputFormatters: keyboardType == TextInputType.number
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r"[\u0660-\u0669\d]+", unicode: true)),
            ]
          : null,

      // Number of lines
      maxLines: lines > 1 ? null : 1,
      minLines: lines,

      // Focus settings
      focusNode: focusNode ?? null,
      autofocus: autoFocus,
      showCursor: showCursor,

      // Input decoration: add hint text, hint
      // text style and remove borders
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: kHintStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),

      // Text change callback
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: width,
            child: Container(
              // Specify the input text height
              height: height + (lines - 1) * height,

              // Create the surrounding box with
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),

              // Place a TextField in the middle of the box
              child: Center(
                child: Row(
                  children: <Widget>[
                    // The field
                    Expanded(flex: 2, child: getField()),

                    // // Validation
                    // (validate && (validator != null) && !validator())
                    //     ? Expanded(
                    //         flex: 1,
                    //         child: Text(
                    //           errorMessage,
                    //           textAlign: TextAlign.end,
                    //           style: kErrorStyle.copyWith(fontSize: 10.0),
                    //           softWrap: true,
                    //         ),
                    //       )
                    //     : Container(),

                    // If loading, show small gap and progress indicator
                    isLoading ? SizedBox(width: 20.0) : Container(),
                    isLoading
                        ? SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: TkProgressIndicator())
                        : icon != null
                            ? Icon(icon, color: kPrimaryIconColor)
                            : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Validation
        (validate && (validator != null) && !validator())
            ? Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.start,
                  style: kErrorStyle,
                  softWrap: true,
                ),
              )
            : Container(),
      ],
    );
  }
}

/// Date selection field
class TkDateField extends TkTextField {
  TkDateField({
    isLoading = false,
    enabled = true,
    onChanged,
    keyboardType,
    obscureText = false,
    hintText,
    halfSize = false,
    validator,
    validate = false,
    errorMessage,
    borderRadius = kDefaultTextEditRadius,
    width,
    height = kDefaultTextEditHeight,
    internalHPadding = kDefaultTextEditInternalPadding,
    internalVPadding = kDefaultTextEditInternalPadding,
    raised = false,
    align = TextAlign.start,
    focusNode,
    autoFocus = false,
    style,
    showCursor = true,
    this.value,
    @required this.context,
    this.type = TkInfoFieldType.Date,
    this.allowFuture = false,
    this.allowPast = true,
    this.locale = LocaleType.en,
  }) : super(
          isLoading: isLoading,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          hintText: hintText,
          halfSize: halfSize,
          validator: validator,
          validate: validate,
          errorMessage: errorMessage,
          borderRadius: borderRadius,
          width: width,
          height: height,
          internalHPadding: internalHPadding,
          internalVPadding: internalVPadding,
          raised: raised,
          align: align,
          focusNode: focusNode,
          autoFocus: autoFocus,
          style: style,
          showCursor: showCursor,
        );

  final DateTime value;
  final BuildContext context;
  final TkInfoFieldType type;
  final bool allowFuture;
  final bool allowPast;
  final LocaleType locale;

  String _formatValue(DateTime value) {
    if (value == null) return hintText ?? '';

    switch (type) {
      case TkInfoFieldType.Date:
        // Date only
        return TkDateTimeHelper.formatDate(value.toString());
      case TkInfoFieldType.Time:
        // Time only
        return TkDateTimeHelper.formatTime(context, value.toString());
      case TkInfoFieldType.DateTime:
        // Date and Time
        String date =
            TkDateTimeHelper.formatDate(value.toString().split(' ').first);
        String time = TkDateTimeHelper.formatTime(
            context, value.toString().split(' ').last);

        return date + ' - ' + time;
      default:
        break;
    }
    return value.toString();
  }

  void _showPicker() {
    switch (type) {
      case TkInfoFieldType.Date:
        // Date only
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: allowPast ? DateTime(1900, 1, 1) : DateTime.now(),
          maxTime: allowFuture
              ? DateTime.now().add(Duration(days: 365 * 10))
              : DateTime.now(),
          theme: DatePickerTheme(
            headerColor: kWhiteColor,
            backgroundColor: kWhiteColor,
            itemStyle: kTextEditStyle,
            doneStyle: kTextEditStyle,
          ),
          onChanged: (date) {},
          onConfirm: (date) => onChanged(date),
          currentTime: value,
          locale: locale,
        );
        break;
      case TkInfoFieldType.Time:
        // Time only
        DatePicker.showTime12hPicker(
          context,
          showTitleActions: true,
          theme: DatePickerTheme(
            headerColor: kWhiteColor,
            backgroundColor: kWhiteColor,
            itemStyle: kTextEditStyle,
            doneStyle: kTextEditStyle,
          ),
          onChanged: (time) {},
          onConfirm: (time) => onChanged(time),
          currentTime: value,
          locale: locale,
        );
        break;
      case TkInfoFieldType.DateTime:
        // Date and Time
        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(1900, 1, 1),
          maxTime: allowFuture
              ? DateTime.now().add(Duration(days: 365 * 10))
              : DateTime.now(),
          theme: DatePickerTheme(
            headerColor: kWhiteColor,
            backgroundColor: kWhiteColor,
            itemStyle: kTextEditStyle,
            doneStyle: kTextEditStyle,
          ),
          onChanged: (date) {},
          onConfirm: (date) => onChanged(date),
          currentTime: value,
          locale: locale,
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget getField() {
    return Container(
      // Create the surrounding box with
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: kAccentGreyColor, width: 1),
      ),
      height: kDefaultTextEditHeight,
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0, 0),
      child: GestureDetector(
        onTap: enabled
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());

                _showPicker();
              }
            : null,
        child: Text(
          _formatValue(value),
          style: value == null ? kHintStyle : kTextEditStyle,
          textAlign: align,
        ),
      ),
    );
  }
}

/// Dropdown selection field
class TkDropDownField extends TkTextField {
  TkDropDownField({
    isLoading = false,
    enabled = true,
    onChanged,
    keyboardType,
    obscureText = false,
    hintText,
    halfSize = false,
    validator,
    validate = false,
    errorMessage,
    borderRadius = kDefaultTextEditRadius,
    width,
    height = kDefaultTextEditHeight,
    internalHPadding = kDefaultTextEditInternalPadding,
    internalVPadding = kDefaultTextEditInternalPadding,
    raised = false,
    align = TextAlign.start,
    focusNode,
    autoFocus = false,
    style,
    showCursor = true,
    this.value,
    @required this.values,
    @required this.context,
  }) : super(
          isLoading: isLoading,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          hintText: hintText,
          halfSize: halfSize,
          validator: validator,
          validate: validate,
          errorMessage: errorMessage,
          borderRadius: borderRadius,
          width: width,
          height: height,
          internalHPadding: internalHPadding,
          internalVPadding: internalVPadding,
          raised: raised,
          align: align,
          focusNode: focusNode,
          autoFocus: autoFocus,
          style: style,
          showCursor: showCursor,
        );

  final String value;
  final List<String> values;
  final BuildContext context;

  List<DropdownMenuItem<String>> getItems() {
    List<DropdownMenuItem<String>> widgets = [];

    // Loop on values and create DropDownMenuItem widget for each
    for (var value in values) {
      widgets.add(
        DropdownMenuItem<String>(
          // The value for the ddm will be its label
          value: value,

          // The label will also be the value
          child: FittedBox(
            child: Text(
              value,
              style:
                  enabled ? style : style.copyWith(color: kDisabledTextColor),
              textAlign: align,
            ),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget getField() {
    return Container(
      // Create the surrounding box with
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: kAccentGreyColor, width: 1),
      ),
      height: kDefaultTextEditHeight,
      padding: EdgeInsetsDirectional.fromSTEB(10.0, 0, 10.0, 0),

      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: kWhiteColor),
        child: DropdownButton<String>(
          elevation: 0,
          value: value,
          iconSize: kDefaultTextEditIconSize,
          iconEnabledColor: kHintTextColor,
          isExpanded: true,
          itemHeight: kDefaultTextEditTitleSize,
          underline: Container(),

          hint: Text(hintText, style: kHintStyle),

          // Get the items
          items: getItems(),

          // On changed action
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/// Dropdown selection field
class TkSearchableDropDownField extends TkTextField {
  TkSearchableDropDownField({
    isLoading = false,
    enabled = true,
    onChanged,
    keyboardType,
    obscureText = false,
    hintText,
    halfSize = false,
    validator,
    validate = false,
    errorMessage,
    borderRadius = kDefaultTextEditRadius,
    width,
    height = kDefaultTextEditHeight,
    internalHPadding = kDefaultTextEditInternalPadding,
    internalVPadding = kDefaultTextEditInternalPadding,
    raised = false,
    align = TextAlign.start,
    focusNode,
    autoFocus = false,
    style,
    showCursor = true,
    this.value,
    @required this.values,
    @required this.context,
    this.controller,
  }) : super(
          isLoading: isLoading,
          enabled: enabled,
          onChanged: onChanged,
          keyboardType: keyboardType,
          obscureText: obscureText,
          hintText: hintText,
          halfSize: halfSize,
          validator: validator,
          validate: validate,
          errorMessage: errorMessage,
          borderRadius: borderRadius,
          width: width,
          height: height,
          internalHPadding: internalHPadding,
          internalVPadding: internalVPadding,
          raised: raised,
          align: align,
          focusNode: focusNode,
          autoFocus: autoFocus,
          style: style,
          showCursor: showCursor,
        );

  final String value;
  final List<String> values;
  final BuildContext context;
  final TextEditingController controller;

  @override
  Widget getField() {
    return Container(
      // Create the surrounding box with
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: kAccentGreyColor, width: 1),
      ),
      // padding: EdgeInsetsDirectional.fromSTEB(10.0, 0, 10.0, 0),

      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: kWhiteColor),
        child: DropDownField(
          controller: controller,
          value: value,
          required: false,
          strict: false,
          labelText: hintText,
          items: values,
          setter: onChanged,
          enabled: enabled,
          textStyle: style,
          onValueChanged: onChanged,
          itemsVisibleInDropdown: 2,
          hintStyle: style,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: width,
            child: Container(
              // Specify the input text height
              // height: height + (lines - 1) * height,

              // Create the surrounding box with
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),

              // Place a TextField in the middle of the box
              child: Center(
                child: Row(
                  children: <Widget>[
                    // The field
                    Expanded(flex: 2, child: getField()),

                    // If loading, show small gap and progress indicator
                    isLoading ? SizedBox(width: 20.0) : Container(),
                    isLoading
                        ? SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: TkProgressIndicator())
                        : icon != null
                            ? Icon(icon, color: kPrimaryIconColor)
                            : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Validation
        (validate && (validator != null) && !validator())
            ? Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  errorMessage,
                  textAlign: TextAlign.start,
                  style: kErrorStyle,
                  softWrap: true,
                ),
              )
            : Container(),
      ],
    );
  }
}
