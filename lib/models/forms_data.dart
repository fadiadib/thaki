import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

const String kLoginIntroTitle = 'Welcome Back!';
Map<String, dynamic> kLoginFieldsJson = {
  kFormName: 'Log In',
  kFormAction: 'Log In',
  kInfoFieldsTag: [
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: kUserPasswordTag,
      kIFTitle: 'Password',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserRememberTag,
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
      kIFName: kUserNameTag,
      kIFTitle: 'Full Name',
      kIFRequired: true,
      kIFType: TkInfoFieldType.AlphaNum.index,
    },
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: kUserAgeTag,
      kIFTitle: 'Age',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Double.index,
    },
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
    {
      kIFName: kUserPasswordTag,
      kIFTitle: 'Password',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserConfirmPasswordTag,
      kIFTitle: 'Confirm Password',
      kIFRequired: true,
      kIFType: TkInfoFieldType.ConfirmPassword.index,
    },
    {
      kIFName: kUserRememberTag,
      kIFTitle: 'Remember Me',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Boolean.index,
    },
  ]
};

Map<String, dynamic> kResetFieldsJson = {
  kFormName: 'Reset Password',
  kFormAction: 'Reset Password',
  kInfoFieldsTag: [
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
  ]
};

Map<String, dynamic> kOTPFieldsJson = {
  kFormName: 'Reset Password',
  kFormAction: 'Confirm',
  kInfoFieldsTag: [
    {
      kIFName: kUserOTPTag,
      kIFTitle: 'OTP',
      kIFRequired: true,
      kIFType: TkInfoFieldType.OTP.index,
    },
  ]
};

Map<String, dynamic> kEditProfileFieldsJson = {
  kFormName: 'Edit Personal Information',
  kFormAction: 'Update',
  kInfoFieldsTag: [
    {
      kIFName: kUserNameTag,
      kIFTitle: 'Full Name',
      kIFRequired: true,
      kIFType: TkInfoFieldType.AlphaNum.index,
    },
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
    {
      kIFName: kUserAgeTag,
      kIFTitle: 'Age',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Double.index,
    },
    {
      kIFName: kUserPasswordTag,
      kIFTitle: 'Password',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserConfirmPasswordTag,
      kIFTitle: 'Confirm Password',
      kIFRequired: false,
      kIFType: TkInfoFieldType.ConfirmPassword.index,
    },
  ]
};

Map<String, dynamic> kResidentPermitFieldsJson = {
  kFormName: 'Enter Personal Information',
  kFormAction: 'Confirm',
  kInfoFieldsTag: [
    {
      kIFName: kUserNameTag,
      kIFTitle: 'Full Name',
      kIFRequired: true,
      kIFType: TkInfoFieldType.AlphaNum.index,
    },
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
  ]
};
