import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

const String kLoginIntroTitle = 'Welcome Back!';
Map<String, dynamic> kLoginFieldsJson = {
  kFormName: 'Log In',
  kFormAction: 'Log In',
  kInfoFieldsTag: [
    {
      kIFName: 'Email',
      kIFTitle: 'Email',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: 'Password',
      kIFTitle: 'Password',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: 'Remember Me',
      kIFTitle: 'Remember Me',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Boolean.index,
    },
  ]
};

Map<String, dynamic> kRegisterFieldsJson = {
  kFormName: 'Register',
  kFormAction: 'Register',
  kInfoFieldsTag: [
    {
      kIFName: 'Full Name',
      kIFTitle: 'Full Name',
      kIFRequired: true,
      kIFType: TkInfoFieldType.AlphaNum.index,
    },
    {
      kIFName: 'Email',
      kIFTitle: 'Email',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: 'Phone',
      kIFTitle: 'Phone',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
    {
      kIFName: 'Password',
      kIFTitle: 'Password',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: 'Confirm Password',
      kIFTitle: 'Confirm Password',
      kIFRequired: true,
      kIFType: TkInfoFieldType.ConfirmPassword.index,
    },
  ]
};

Map<String, dynamic> kResetFieldsJson = {
  kFormName: 'Reset Password',
  kFormAction: 'Reset Password',
  kInfoFieldsTag: [
    {
      kIFName: 'Phone',
      kIFTitle: 'Phone',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
  ]
};

Map<String, dynamic> kEditProfileFieldsJson = {
  kFormName: 'Edit Personal Information',
  kFormAction: 'Update',
  kInfoFieldsTag: [
    {
      kIFName: 'Full Name',
      kIFTitle: 'Full Name',
      kIFRequired: true,
      kIFType: TkInfoFieldType.AlphaNum.index,
    },
    {
      kIFName: 'Email',
      kIFTitle: 'Email',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: 'Phone',
      kIFTitle: 'Phone',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
    {
      kIFName: 'Password',
      kIFTitle: 'Password',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: 'Confirm Password',
      kIFTitle: 'Confirm Password',
      kIFRequired: false,
      kIFType: TkInfoFieldType.ConfirmPassword.index,
    },
  ]
};
