import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/info_fields.dart';
import 'package:thaki/utilities/form_builder.dart';
import 'package:thaki/utilities/formfield_validator.dart';
import 'package:thaki/utilities/validation_helper.dart';
import 'package:thaki/widgets/forms/button.dart';

class TkFormFrame extends StatefulWidget {
  TkFormFrame({
    this.action,
    this.actionTitle,
    this.formTitle,
    this.introTitle,
    this.fields,
    this.buttonTag = 'action',
    this.footer,
    this.validatePasswordMatch,
    this.validatePassword,
    this.passwordError,
    this.child,
    this.isLoading = false,
    this.langCode = 'en',
  });

  final String formTitle;
  final String introTitle;
  final String actionTitle;
  final Function action;
  final TkInfoFieldsList fields;
  final String buttonTag;
  final Widget footer;
  final Function validatePasswordMatch;
  final Function validatePassword;
  final String passwordError;
  final Widget child;
  final bool isLoading;
  final String langCode;

  @override
  _TkFormFrameState createState() => _TkFormFrameState();
}

class _TkFormFrameState extends State<TkFormFrame>
    with TkFormFieldValidatorMixin {
  @override
  bool validate() {
    for (TkInfoField field in widget.fields.fields) {
      if (!validateInfoField(field)) return false;
    }
    return true;
  }

  /// validateField is not used
  @override
  bool validateField(TkFormField field, dynamic value) => false;

  /// Validates the different types of info fields
  bool validateInfoField(TkInfoField field) {
    if (!field.required) return true;

    switch (field.type) {
      case TkInfoFieldType.NationalId:
        // National ID type
        return TkValidationHelper.validateNationalID(field.value);
      case TkInfoFieldType.Email:
        // Email type
        return TkValidationHelper.validateEmail(field.value);
      case TkInfoFieldType.Phone:
        // Phone type
        return TkValidationHelper.validatePhone(field.value);
      case TkInfoFieldType.Boolean:
        // Boolean
        return true;
      case TkInfoFieldType.Date:
      case TkInfoFieldType.DateTime:
      case TkInfoFieldType.Time:
      case TkInfoFieldType.AlphaNum:
      case TkInfoFieldType.Double:
      case TkInfoFieldType.Radio:
      case TkInfoFieldType.DropDown:
      case TkInfoFieldType.ConfirmPassword:
      case TkInfoFieldType.OTP:
        return TkValidationHelper.validateNotEmpty(field.value);
      case TkInfoFieldType.Password:
        return TkValidationHelper.validatePassword(field.value);
      case TkInfoFieldType.Name:
        return TkValidationHelper.validateName(field.value);
    }
    return false;
  }

  String _getLabel(TkInfoField field) {
    return widget.langCode == 'en' ? field.label : field.labelAR ?? field.label;
  }

  /// Loops the visible info fields and creates a form with all the widgets
  List<Widget> _createInfoFieldsWidgets(
      TkInfoFieldsList fields, BuildContext context) {
    List<Widget> widgets = [];

    // Loop on the fields and create corresponding widgets
    for (TkInfoField field in fields.fields) {
      if (field.visible)
        widgets.add(
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: field.type == TkInfoFieldType.Boolean ? 0.0 : 5.0),
              child: _createFormFieldWidget(field, context)),
        );
    }

    return widgets;
  }

  /// Checks the info field type and creates the corresponding widget
  Widget _createFormFieldWidget(TkInfoField field, BuildContext context) {
    Widget widget;
    switch (field.type) {
      case TkInfoFieldType.NationalId:
        // National ID type
        widget = TkFormBuilder.createTextField(
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          keyboardType: TextInputType.number,
          onChanged: (value) => setState(() => field.value = value),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
          errorMessage: S.of(context).kPleaseEnter + _getLabel(field),
        );
        break;
      case TkInfoFieldType.Name:
      case TkInfoFieldType.AlphaNum:
        // AlphaNum type
        widget = TkFormBuilder.createTextField(
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          keyboardType: field.subType == TkInfoFieldSubType.Numeric
              ? TextInputType.number
              : TextInputType.text,
          onChanged: (value) => setState(() => field.value = value),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
          errorMessage: S.of(context).kPleaseEnter + _getLabel(field),
          lines: field.numLines,
        );
        break;
      case TkInfoFieldType.Double:
        // Double type
        widget = TkFormBuilder.createTextField(
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value?.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          onChanged: (value) => setState(() => field.value = value),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
          errorMessage: S.of(context).kPleaseEnter + _getLabel(field),
        );
        break;
      case TkInfoFieldType.Password:
        // Password type
        widget = TkFormBuilder.createTextField(
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          keyboardType: field.subType == TkInfoFieldSubType.Numeric
              ? TextInputType.number
              : TextInputType.text,
          onChanged: (value) => setState(() => field.value = value),
          obscured: true,
          isValidating: isValidating,
          validator: () {
            if (this.widget.validatePassword != null) {
              return this.widget.validatePassword(field);
            } else
              return validateInfoField(field);
          },
          errorMessage: this.widget.passwordError ??
              S.of(context).kPleaseEnter + _getLabel(field),
        );
        break;
      case TkInfoFieldType.ConfirmPassword:
        // Password type
        widget = TkFormBuilder.createTextField(
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          keyboardType: field.subType == TkInfoFieldSubType.Numeric
              ? TextInputType.number
              : TextInputType.text,
          onChanged: (value) => setState(() => field.value = value),
          obscured: true,
          isValidating: true,
          validator: () {
            if (this.widget.validatePasswordMatch != null) {
              return this.widget.validatePasswordMatch(field);
            } else
              return validateInfoField(field);
          },
          errorMessage: S.of(context).kPasswordMismatch,
        );
        break;
      case TkInfoFieldType.Email:
        // Email type
        widget = TkFormBuilder.createTextField(
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => setState(() => field.value = value),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
          errorMessage: S.of(context).kPleaseEnterAValid + _getLabel(field),
        );
        break;
      case TkInfoFieldType.Phone:
        // Phone type
        widget = TkFormBuilder.createTextField(
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          keyboardType: TextInputType.phone,
          onChanged: (value) => setState(() => field.value = value),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
          errorMessage: S.of(context).kPleaseEnterAValid + _getLabel(field),
        );
        break;
      case TkInfoFieldType.Date:
      case TkInfoFieldType.Time:
      case TkInfoFieldType.DateTime:
        widget = TkFormBuilder.createDateTimeField(
          context: context,
          enabled: !this.widget.isLoading,
          type: field.type,
          label: _getLabel(field),
          value: field.value,
          onChanged: (value) {
            setState(() => field.value = value.toString());
          },
          errorMessage: S.of(context).kPleaseChoose + _getLabel(field),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
          locale: this.widget.langCode == 'en' ? LocaleType.en : LocaleType.ar,
        );
        break;
      case TkInfoFieldType.Boolean:
        widget = TkFormBuilder.createCheckBox(
          label: _getLabel(field),
          value: field.value != null &&
              field.value.isNotEmpty &&
              field.value != 'false' &&
              field.value != '0',
          onChanged: (value) => setState(() => field.value = value.toString()),
        );
        break;
      case TkInfoFieldType.Radio:
      case TkInfoFieldType.DropDown:
        // Dropdown and radio types
        widget = TkFormBuilder.createDropDownField(
          context: context,
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          onChanged: (value) => setState(() => field.value = value),
          errorMessage: S.of(context).kPleaseChoose + _getLabel(field),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
          values: field.valueOptions,
        );
        break;
      case TkInfoFieldType.OTP:
        // OTP
        widget = TkFormBuilder.createOTP(
          context: context,
          enabled: !this.widget.isLoading,
          label: _getLabel(field),
          initialValue: field.value,
          onChanged: (value) {
            setState(() => field.value = value);
          },
          errorMessage: S.of(context).kPleaseEnter + _getLabel(field),
          isValidating: isValidating,
          validator: () => validateInfoField(field),
        );
        break;
    }

    // Return the created widget
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      padding: EdgeInsets.all(20.0),

      // Internal container
      child: Container(
        // Form frame shadow
        decoration: BoxDecoration(
          color: kFormBgColor,
          boxShadow: kFormShadow,
          borderRadius: BorderRadius.circular(10.0),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intro title
              if (widget.introTitle != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.introTitle,
                    style: kBoldStyle[kSmallSize],
                  ),
                ),

              // Form title
              if (widget.formTitle != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    widget.formTitle,
                    style: kBoldStyle[kBigSize].copyWith(color: kPrimaryColor),
                  ),
                ),

              // Separator
              if (widget.introTitle != null || widget.formTitle != null)
                Divider(color: kAccentGreyColor, thickness: 1.0),

              // Render info fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _createInfoFieldsWidgets(widget.fields, context),
                ),
              ),

              // Footer widget
              if (widget.child != null) widget.child,

              // Action button
              if (widget.action != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Hero(
                    tag: widget.buttonTag,
                    child: TkButton(
                      title: widget.actionTitle,
                      isLoading: this.widget.isLoading,
                      onPressed: () async {
                        // Enable validation
                        setState(() => startValidating());
                        // Validate form
                        if (validate()) {
                          // Validation successful
                          stopValidating();

                          // Callback
                          widget.action(widget.fields);
                        }
                      },
                    ),
                  ),
                ),

              // Footer widget
              if (widget.footer != null) widget.footer,
            ],
          ),
        ),
      ),
    );
  }
}
