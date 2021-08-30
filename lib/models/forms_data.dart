import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

Map<String, dynamic> kLoginFieldsJson = {
  kFormName: {'en': 'Log In', 'ar': 'تسجيل الدخول'},
  kFormAction: {'en': 'Log In', 'ar': 'تسجيل الدخول'},
  kInfoFieldsTag: [
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFTitleAR: 'البريد الالكتروني',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: kUserPasswordTag,
      kIFTitle: 'Password',
      kIFTitleAR: 'كلمة المرور',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserRememberTag,
      kIFTitle: 'Remember Me',
      kIFTitleAR: 'حفظ البيانات',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Boolean.index,
    },
  ]
};

Map<String, dynamic> kRegisterFieldsJson = {
  kFormName: {'en': 'Register', 'ar': 'إنشاء حساب'},
  kFormAction: {'en': 'Register', 'ar': 'إنشاء حساب'},
  kInfoFieldsTag: [
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFTitleAR: 'البريد الالكتروني',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: kUserBirthDateTag,
      kIFTitle: 'Birth date',
      kIFTitleAR: 'تاريخ الميلاد',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Date.index,
    },
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFTitleAR: 'رقم الهاتف',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
    {
      kIFName: kUserPasswordTag,
      kIFTitle: 'Password',
      kIFTitleAR: 'كلمة المرور',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserConfirmPasswordTag,
      kIFTitle: 'Confirm Password',
      kIFTitleAR: 'تأكيد كلمة المرور',
      kIFRequired: true,
      kIFType: TkInfoFieldType.ConfirmPassword.index,
    },
    {
      kIFName: kUserRememberTag,
      kIFTitle: 'Remember Me',
      kIFTitleAR: 'حفظ البيانات',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Boolean.index,
    },
  ]
};

Map<String, dynamic> kResetFieldsJson = {
  kFormName: {'en': 'Reset Password', 'ar': 'نسيت كلمة المرور'},
  kFormAction: {'en': 'Reset Password', 'ar': 'تأكيد'},
  kInfoFieldsTag: [
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFTitleAR: 'البريد الالكتروني',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
  ]
};

Map<String, dynamic> kOTPFieldsJson = {
  kFormName: {'en': 'Send OTP', 'ar': 'إرسال الكود'},
  kFormAction: {'en': 'Confirm', 'ar': 'تأكيد'},
  kInfoFieldsTag: [
    {
      kIFName: kUserOTPTag,
      kIFTitle: 'OTP',
      kIFTitleAR: 'الكود',
      kIFRequired: true,
      kIFType: TkInfoFieldType.OTP.index,
    },
    {
      kIFName: kUserPasswordTag,
      kIFTitle: 'Password',
      kIFTitleAR: 'كلمة المرور',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserConfirmPasswordTag,
      kIFTitle: 'Confirm Password',
      kIFTitleAR: 'تأكيد كلمة المرور',
      kIFRequired: true,
      kIFType: TkInfoFieldType.ConfirmPassword.index,
    },
  ]
};

Map<String, dynamic> kEditProfileFieldsJson = {
  kFormName: {
    'en': 'Edit Personal Information',
    'ar': 'تحديث معلومات المستخدم'
  },
  kFormAction: {'en': 'Update', 'ar': 'تحديث'},
  kInfoFieldsTag: [
    // {
    //   kIFName: kUserEmailTag,
    //   kIFTitle: 'Email',
    //   kIFTitleAR: 'البريد الالكتروني',
    //   kIFRequired: true,
    //   kIFType: TkInfoFieldType.Email.index,
    // },
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFTitleAR: 'رقم الهاتف',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
    {
      kIFName: kUserBirthDateTag,
      kIFTitle: 'Birth date',
      kIFTitleAR: 'تاريخ الميلاد',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Date.index,
    },
    {
      kIFName: kUserOldPasswordTag,
      kIFTitle: 'Old Password',
      kIFTitleAR: 'كلمة المرور القديمة',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserPasswordTag,
      kIFTitle: 'New Password',
      kIFTitleAR: 'كلمة المرور الجديدة',
      kIFRequired: false,
      kIFType: TkInfoFieldType.Password.index,
    },
    {
      kIFName: kUserConfirmPasswordTag,
      kIFTitle: 'Confirm Password',
      kIFTitleAR: 'تأكيد كلمة المرور',
      kIFRequired: false,
      kIFType: TkInfoFieldType.ConfirmPassword.index,
    },
  ]
};

Map<String, dynamic> kEditSocialProfileFieldsJson = {
  kFormName: {
    'en': 'Edit Personal Information',
    'ar': 'تحديث معلومات المستخدم'
  },
  kFormAction: {'en': 'Update', 'ar': 'تحديث'},
  kInfoFieldsTag: [
    // {
    //   kIFName: kUserEmailTag,
    //   kIFTitle: 'Email',
    //   kIFTitleAR: 'البريد الالكتروني',
    //   kIFRequired: true,
    //   kIFType: TkInfoFieldType.Email.index,
    // },
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFTitleAR: 'رقم الهاتف',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
    {
      kIFName: kUserBirthDateTag,
      kIFTitle: 'Birth date',
      kIFTitleAR: 'تاريخ الميلاد',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Date.index,
    },
  ]
};

Map<String, dynamic> kResidentPermitFieldsJson = {
  kFormName: {
    'en': 'Enter Personal Information',
    'ar': 'أدخل المعلومات الشخصية'
  },
  kFormAction: {'en': 'Confirm', 'ar': 'تأكيد'},
  kInfoFieldsTag: [
    {
      kIFName: kUserNameTag,
      kIFTitle: 'Full Name',
      kIFTitleAR: 'الاسم بالكامل',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Name.index,
    },
    {
      kIFName: kUserEmailTag,
      kIFTitle: 'Email',
      kIFTitleAR: 'البريد الالكتروني',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Email.index,
    },
    {
      kIFName: kUserPhoneTag,
      kIFTitle: 'Phone',
      kIFTitleAR: 'رقم الهاتف',
      kIFRequired: true,
      kIFType: TkInfoFieldType.Phone.index,
    },
  ]
};
