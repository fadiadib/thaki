// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Thaki`
  String get kAppTitle {
    return Intl.message(
      'Thaki',
      name: 'kAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Package`
  String get kPurchasePackage {
    return Intl.message(
      'Purchase Package',
      name: 'kPurchasePackage',
      desc: '',
      args: [],
    );
  }

  /// `Resident Permit`
  String get kResidentPermit {
    return Intl.message(
      'Resident Permit',
      name: 'kResidentPermit',
      desc: '',
      args: [],
    );
  }

  /// `My Tickets`
  String get kTicketsPaneTitle {
    return Intl.message(
      'My Tickets',
      name: 'kTicketsPaneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get kDashboardPaneTitle {
    return Intl.message(
      'Dashboard',
      name: 'kDashboardPaneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Book Parking`
  String get kParkingPaneTitle {
    return Intl.message(
      'Book Parking',
      name: 'kParkingPaneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get kProfilePaneTitle {
    return Intl.message(
      'Profile',
      name: 'kProfilePaneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pay Violations`
  String get kViolationsPaneTitle {
    return Intl.message(
      'Pay Violations',
      name: 'kViolationsPaneTitle',
      desc: '',
      args: [],
    );
  }

  /// `, `
  String get kWeekDaySep {
    return Intl.message(
      ', ',
      name: 'kWeekDaySep',
      desc: '',
      args: [],
    );
  }

  /// `am`
  String get kAM {
    return Intl.message(
      'am',
      name: 'kAM',
      desc: '',
      args: [],
    );
  }

  /// `pm`
  String get kPM {
    return Intl.message(
      'pm',
      name: 'kPM',
      desc: '',
      args: [],
    );
  }

  /// ` cm`
  String get kCM {
    return Intl.message(
      ' cm',
      name: 'kCM',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get kMon {
    return Intl.message(
      'Mon',
      name: 'kMon',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get kTue {
    return Intl.message(
      'Tue',
      name: 'kTue',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get kWed {
    return Intl.message(
      'Wed',
      name: 'kWed',
      desc: '',
      args: [],
    );
  }

  /// `Thur`
  String get kThur {
    return Intl.message(
      'Thur',
      name: 'kThur',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get kFri {
    return Intl.message(
      'Fri',
      name: 'kFri',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get kSat {
    return Intl.message(
      'Sat',
      name: 'kSat',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get kSun {
    return Intl.message(
      'Sun',
      name: 'kSun',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get kMonday {
    return Intl.message(
      'Monday',
      name: 'kMonday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get kTuesday {
    return Intl.message(
      'Tuesday',
      name: 'kTuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get kWednesday {
    return Intl.message(
      'Wednesday',
      name: 'kWednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get kThursday {
    return Intl.message(
      'Thursday',
      name: 'kThursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get kFriday {
    return Intl.message(
      'Friday',
      name: 'kFriday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get kSaturday {
    return Intl.message(
      'Saturday',
      name: 'kSaturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get kSunday {
    return Intl.message(
      'Sunday',
      name: 'kSunday',
      desc: '',
      args: [],
    );
  }

  /// `Not Found`
  String get kNotFound {
    return Intl.message(
      'Not Found',
      name: 'kNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get kUnknown {
    return Intl.message(
      'Unknown',
      name: 'kUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error Occurred`
  String get UnknownError {
    return Intl.message(
      'Unknown Error Occurred',
      name: 'UnknownError',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Image File`
  String get kUnsupportedImageFile {
    return Intl.message(
      'Unsupported Image File',
      name: 'kUnsupportedImageFile',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get kConfirm {
    return Intl.message(
      'Confirm',
      name: 'kConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get kCancel {
    return Intl.message(
      'Cancel',
      name: 'kCancel',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get kYes {
    return Intl.message(
      'Yes',
      name: 'kYes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get kNo {
    return Intl.message(
      'No',
      name: 'kNo',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get kOk {
    return Intl.message(
      'Ok',
      name: 'kOk',
      desc: '',
      args: [],
    );
  }

  /// `I Agree`
  String get kAgree {
    return Intl.message(
      'I Agree',
      name: 'kAgree',
      desc: '',
      args: [],
    );
  }

  /// `I Disagree`
  String get kDisagree {
    return Intl.message(
      'I Disagree',
      name: 'kDisagree',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Now`
  String get kUpgradeNow {
    return Intl.message(
      'Upgrade Now',
      name: 'kUpgradeNow',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported App Version`
  String get kUnsupportedVersion {
    return Intl.message(
      'Unsupported App Version',
      name: 'kUnsupportedVersion',
      desc: '',
      args: [],
    );
  }

  /// `Please download the latest version to continue using the application`
  String get kUpgradeRequiredMessage {
    return Intl.message(
      'Please download the latest version to continue using the application',
      name: 'kUpgradeRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get kDelete {
    return Intl.message(
      'Delete',
      name: 'kDelete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get kEdit {
    return Intl.message(
      'Edit',
      name: 'kEdit',
      desc: '',
      args: [],
    );
  }

  /// `* Please Enter `
  String get kPleaseEnter {
    return Intl.message(
      '* Please Enter ',
      name: 'kPleaseEnter',
      desc: '',
      args: [],
    );
  }

  /// `* Please Enter a Valid `
  String get kPleaseEnterAValid {
    return Intl.message(
      '* Please Enter a Valid ',
      name: 'kPleaseEnterAValid',
      desc: '',
      args: [],
    );
  }

  /// `* Please Choose `
  String get kPleaseChoose {
    return Intl.message(
      '* Please Choose ',
      name: 'kPleaseChoose',
      desc: '',
      args: [],
    );
  }

  /// `* Password Mismatch`
  String get kPasswordMismatch {
    return Intl.message(
      '* Password Mismatch',
      name: 'kPasswordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Your phone doesn"t have an Internet connection,\nplease check connection and `
  String get kConnectionError {
    return Intl.message(
      'Your phone doesn"t have an Internet connection,\nplease check connection and ',
      name: 'kConnectionError',
      desc: '',
      args: [],
    );
  }

  /// `try again`
  String get kTryAgain {
    return Intl.message(
      'try again',
      name: 'kTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Thaki server unreachable.\nPlease `
  String get kServerError {
    return Intl.message(
      'Thaki server unreachable.\nPlease ',
      name: 'kServerError',
      desc: '',
      args: [],
    );
  }

  /// `App upgrade is required,\nplease upgrade to the latest version\nand `
  String get kVersionError {
    return Intl.message(
      'App upgrade is required,\nplease upgrade to the latest version\nand ',
      name: 'kVersionError',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get kSkip {
    return Intl.message(
      'Skip',
      name: 'kSkip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get kNext {
    return Intl.message(
      'Next',
      name: 'kNext',
      desc: '',
      args: [],
    );
  }

  /// `تطبيق ذكي\nهو أحد حلول المدن الذكية متخصص بإدارة وتشغيل وصيانة المواقف الذكية وإدارة المرافق الخاصة بها`
  String get kOnBoardingMessage1 {
    return Intl.message(
      'تطبيق ذكي\nهو أحد حلول المدن الذكية متخصص بإدارة وتشغيل وصيانة المواقف الذكية وإدارة المرافق الخاصة بها',
      name: 'kOnBoardingMessage1',
      desc: '',
      args: [],
    );
  }

  /// `تأكد وانت واقف\n انك واقف بشكل صحيح وضمن المسارات المحددة للوقوف`
  String get kOnBoardingMessage2 {
    return Intl.message(
      'تأكد وانت واقف\n انك واقف بشكل صحيح وضمن المسارات المحددة للوقوف',
      name: 'kOnBoardingMessage2',
      desc: '',
      args: [],
    );
  }

  /// `ذكي راحة بال`
  String get kOnBoardingMessage3 {
    return Intl.message(
      'ذكي راحة بال',
      name: 'kOnBoardingMessage3',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get kSignUp {
    return Intl.message(
      'Sign Up',
      name: 'kSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get kLogin {
    return Intl.message(
      'Log In',
      name: 'kLogin',
      desc: '',
      args: [],
    );
  }

  /// `You can also login with …`
  String get kYouCanAlsoLoginWith {
    return Intl.message(
      'You can also login with …',
      name: 'kYouCanAlsoLoginWith',
      desc: '',
      args: [],
    );
  }

  /// `Not registered yet? `
  String get kNotRegisteredYet {
    return Intl.message(
      'Not registered yet? ',
      name: 'kNotRegisteredYet',
      desc: '',
      args: [],
    );
  }

  /// `Sign up!`
  String get kSignUpExclamation {
    return Intl.message(
      'Sign up!',
      name: 'kSignUpExclamation',
      desc: '',
      args: [],
    );
  }

  /// `Already registered? `
  String get kAlreadyRegistered {
    return Intl.message(
      'Already registered? ',
      name: 'kAlreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Login!`
  String get kLoginExclamation {
    return Intl.message(
      'Login!',
      name: 'kLoginExclamation',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get kLogOut {
    return Intl.message(
      'Logout',
      name: 'kLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Back to `
  String get kBackTo {
    return Intl.message(
      'Back to ',
      name: 'kBackTo',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get kForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'kForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the six digit code received on your registered phone number/Email`
  String get kEnterOTPMessage {
    return Intl.message(
      'Please enter the six digit code received on your registered phone number/Email',
      name: 'kEnterOTPMessage',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get kPersonalInfo {
    return Intl.message(
      'Personal Information',
      name: 'kPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Edit Personal Info`
  String get kEditPersonalInfo {
    return Intl.message(
      'Edit Personal Info',
      name: 'kEditPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `My Cars`
  String get kMyCars {
    return Intl.message(
      'My Cars',
      name: 'kMyCars',
      desc: '',
      args: [],
    );
  }

  /// `My Cards`
  String get kMyCards {
    return Intl.message(
      'My Cards',
      name: 'kMyCards',
      desc: '',
      args: [],
    );
  }

  /// `My Bookings`
  String get kMyBookings {
    return Intl.message(
      'My Bookings',
      name: 'kMyBookings',
      desc: '',
      args: [],
    );
  }

  /// `My Balance`
  String get kMyBalance {
    return Intl.message(
      'My Balance',
      name: 'kMyBalance',
      desc: '',
      args: [],
    );
  }

  /// `No cars added yet`
  String get kNoCars {
    return Intl.message(
      'No cars added yet',
      name: 'kNoCars',
      desc: '',
      args: [],
    );
  }

  /// `Car Name`
  String get kCarName {
    return Intl.message(
      'Car Name',
      name: 'kCarName',
      desc: '',
      args: [],
    );
  }

  /// `Car Plate`
  String get kCarPlate {
    return Intl.message(
      'Car Plate',
      name: 'kCarPlate',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get kCarState {
    return Intl.message(
      'Country',
      name: 'kCarState',
      desc: '',
      args: [],
    );
  }

  /// `No payment cards added yet`
  String get kNoPaymentCards {
    return Intl.message(
      'No payment cards added yet',
      name: 'kNoPaymentCards',
      desc: '',
      args: [],
    );
  }

  /// `Password will not be changed if left empty`
  String get kPasswordWontChange {
    return Intl.message(
      'Password will not be changed if left empty',
      name: 'kPasswordWontChange',
      desc: '',
      args: [],
    );
  }

  /// `No bookings yet`
  String get kNoBookingsYet {
    return Intl.message(
      'No bookings yet',
      name: 'kNoBookingsYet',
      desc: '',
      args: [],
    );
  }

  /// `Book your parking`
  String get kBookParking {
    return Intl.message(
      'Book your parking',
      name: 'kBookParking',
      desc: '',
      args: [],
    );
  }

  /// `Current Balance`
  String get kCurrentBalance {
    return Intl.message(
      'Current Balance',
      name: 'kCurrentBalance',
      desc: '',
      args: [],
    );
  }

  /// `Valid until`
  String get kValidTill {
    return Intl.message(
      'Valid until',
      name: 'kValidTill',
      desc: '',
      args: [],
    );
  }

  /// `Recharge your balance`
  String get kRechargeBalance {
    return Intl.message(
      'Recharge your balance',
      name: 'kRechargeBalance',
      desc: '',
      args: [],
    );
  }

  /// `Apply for subscription`
  String get kApplySubscription {
    return Intl.message(
      'Apply for subscription',
      name: 'kApplySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Purchase subscription`
  String get kBuySubscription {
    return Intl.message(
      'Purchase subscription',
      name: 'kBuySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get kHours {
    return Intl.message(
      'Hours',
      name: 'kHours',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get kContinue {
    return Intl.message(
      'Continue',
      name: 'kContinue',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get kCheckout {
    return Intl.message(
      'Checkout',
      name: 'kCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get kSuccess {
    return Intl.message(
      'Success!',
      name: 'kSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error!`
  String get kFailure {
    return Intl.message(
      'Error!',
      name: 'kFailure',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get kClose {
    return Intl.message(
      'Close',
      name: 'kClose',
      desc: '',
      args: [],
    );
  }

  /// `I Agree`
  String get kIAgree {
    return Intl.message(
      'I Agree',
      name: 'kIAgree',
      desc: '',
      args: [],
    );
  }

  /// `Pay Violations`
  String get kPayViolations {
    return Intl.message(
      'Pay Violations',
      name: 'kPayViolations',
      desc: '',
      args: [],
    );
  }

  /// `Choose Car`
  String get kChooseCar {
    return Intl.message(
      'Choose Car',
      name: 'kChooseCar',
      desc: '',
      args: [],
    );
  }

  /// `Card holder name`
  String get kCardHolderName {
    return Intl.message(
      'Card holder name',
      name: 'kCardHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Credit card number`
  String get kCardNumber {
    return Intl.message(
      'Credit card number',
      name: 'kCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Expires`
  String get kCardExpires {
    return Intl.message(
      'Expires',
      name: 'kCardExpires',
      desc: '',
      args: [],
    );
  }

  /// `Expires (YYYY-MM)`
  String get kCardExpiresYm {
    return Intl.message(
      'Expires (YYYY-MM)',
      name: 'kCardExpiresYm',
      desc: '',
      args: [],
    );
  }

  /// `Expiry`
  String get kCardExpiry {
    return Intl.message(
      'Expiry',
      name: 'kCardExpiry',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get kCardCVV {
    return Intl.message(
      'CVV',
      name: 'kCardCVV',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get kSave {
    return Intl.message(
      'Save',
      name: 'kSave',
      desc: '',
      args: [],
    );
  }

  /// `Car nickname`
  String get kCarNickname {
    return Intl.message(
      'Car nickname',
      name: 'kCarNickname',
      desc: '',
      args: [],
    );
  }

  /// `Car license plate (EN)`
  String get kCarPlateEN {
    return Intl.message(
      'Car license plate (EN)',
      name: 'kCarPlateEN',
      desc: '',
      args: [],
    );
  }

  /// `Car license plate (AR)`
  String get kCarPlateAR {
    return Intl.message(
      'Car license plate (AR)',
      name: 'kCarPlateAR',
      desc: '',
      args: [],
    );
  }

  /// ` - Example: 1234ABC`
  String get kCarPlateHint {
    return Intl.message(
      ' - Example: 1234ABC',
      name: 'kCarPlateHint',
      desc: '',
      args: [],
    );
  }

  /// `Make`
  String get kCarMake {
    return Intl.message(
      'Make',
      name: 'kCarMake',
      desc: '',
      args: [],
    );
  }

  /// `Model`
  String get kCarModel {
    return Intl.message(
      'Model',
      name: 'kCarModel',
      desc: '',
      args: [],
    );
  }

  /// `Preferred`
  String get kCarIsPreferred {
    return Intl.message(
      'Preferred',
      name: 'kCarIsPreferred',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get kFrom {
    return Intl.message(
      'From',
      name: 'kFrom',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get kTo {
    return Intl.message(
      'To',
      name: 'kTo',
      desc: '',
      args: [],
    );
  }

  /// `Hour Package`
  String get kHourPackage {
    return Intl.message(
      'Hour Package',
      name: 'kHourPackage',
      desc: '',
      args: [],
    );
  }

  /// `Valid for`
  String get kValidFor {
    return Intl.message(
      'Valid for',
      name: 'kValidFor',
      desc: '',
      args: [],
    );
  }

  /// `days`
  String get kDays {
    return Intl.message(
      'days',
      name: 'kDays',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get kSAR {
    return Intl.message(
      'SAR',
      name: 'kSAR',
      desc: '',
      args: [],
    );
  }

  /// `Package Details`
  String get kPackageDetails {
    return Intl.message(
      'Package Details',
      name: 'kPackageDetails',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get kPaymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'kPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Package purchased successfully`
  String get kPurchaseSuccess {
    return Intl.message(
      'Package purchased successfully',
      name: 'kPurchaseSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Apply for resident permit`
  String get kApplyForResidentPermit {
    return Intl.message(
      'Apply for resident permit',
      name: 'kApplyForResidentPermit',
      desc: '',
      args: [],
    );
  }

  /// `Request submitted successfully, you will be notified once your application has been reviewed`
  String get kPermitSuccess {
    return Intl.message(
      'Request submitted successfully, you will be notified once your application has been reviewed',
      name: 'kPermitSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Upload Required Documents`
  String get kUploadDocument {
    return Intl.message(
      'Upload Required Documents',
      name: 'kUploadDocument',
      desc: '',
      args: [],
    );
  }

  /// `All Data uploaded is secured and can only be used for verification purposes only`
  String get kSecuredData {
    return Intl.message(
      'All Data uploaded is secured and can only be used for verification purposes only',
      name: 'kSecuredData',
      desc: '',
      args: [],
    );
  }

  /// `Select from Phone Gallery`
  String get kSelectFromPhoneGallery {
    return Intl.message(
      'Select from Phone Gallery',
      name: 'kSelectFromPhoneGallery',
      desc: '',
      args: [],
    );
  }

  /// `ID Card (Front)`
  String get kIDFront {
    return Intl.message(
      'ID Card (Front)',
      name: 'kIDFront',
      desc: '',
      args: [],
    );
  }

  /// `ID Card (Back)`
  String get kIDBack {
    return Intl.message(
      'ID Card (Back)',
      name: 'kIDBack',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get kUploadImage {
    return Intl.message(
      'Upload Image',
      name: 'kUploadImage',
      desc: '',
      args: [],
    );
  }

  /// `Please upload all documents to proceed`
  String get kUploadDocumentsToProceed {
    return Intl.message(
      'Please upload all documents to proceed',
      name: 'kUploadDocumentsToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Enter another LPR`
  String get kCheckForLPR {
    return Intl.message(
      'Enter another LPR',
      name: 'kCheckForLPR',
      desc: '',
      args: [],
    );
  }

  /// `Enter one time car LPR`
  String get kEnterLRP {
    return Intl.message(
      'Enter one time car LPR',
      name: 'kEnterLRP',
      desc: '',
      args: [],
    );
  }

  /// `Current Violations`
  String get kCurrentViolations {
    return Intl.message(
      'Current Violations',
      name: 'kCurrentViolations',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get kTotal {
    return Intl.message(
      'Total',
      name: 'kTotal',
      desc: '',
      args: [],
    );
  }

  /// `Pay Selected`
  String get kPaySelected {
    return Intl.message(
      'Pay Selected',
      name: 'kPaySelected',
      desc: '',
      args: [],
    );
  }

  /// `Fine paid successfully, please allow 30 minutes for updates on CivicSmart system`
  String get kFinePaymentSuccess {
    return Intl.message(
      'Fine paid successfully, please allow 30 minutes for updates on CivicSmart system',
      name: 'kFinePaymentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one violation to proceed to payment`
  String get kSelectViolationToProceed {
    return Intl.message(
      'Please select at least one violation to proceed to payment',
      name: 'kSelectViolationToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Please select a payment method to proceed`
  String get kSelectPaymentToProceed {
    return Intl.message(
      'Please select a payment method to proceed',
      name: 'kSelectPaymentToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your car license plate to proceed`
  String get kSelectCardToProceed {
    return Intl.message(
      'Please enter your car license plate to proceed',
      name: 'kSelectCardToProceed',
      desc: '',
      args: [],
    );
  }

  /// `Pick parking time`
  String get kPickParkingTime {
    return Intl.message(
      'Pick parking time',
      name: 'kPickParkingTime',
      desc: '',
      args: [],
    );
  }

  /// `Book parking now`
  String get kBookParkingNow {
    return Intl.message(
      'Book parking now',
      name: 'kBookParkingNow',
      desc: '',
      args: [],
    );
  }

  /// `Select date and time`
  String get kSelectDateTime {
    return Intl.message(
      'Select date and time',
      name: 'kSelectDateTime',
      desc: '',
      args: [],
    );
  }

  /// `date and time`
  String get kDateTime {
    return Intl.message(
      'date and time',
      name: 'kDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Parking Duration`
  String get kParkingDuration {
    return Intl.message(
      'Parking Duration',
      name: 'kParkingDuration',
      desc: '',
      args: [],
    );
  }

  /// `Park for`
  String get kParkFor {
    return Intl.message(
      'Park for',
      name: 'kParkFor',
      desc: '',
      args: [],
    );
  }

  /// `Parking Confirmed, QR code will be available 15 minutes before parking time`
  String get kParkSuccess {
    return Intl.message(
      'Parking Confirmed, QR code will be available 15 minutes before parking time',
      name: 'kParkSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get kUpcoming {
    return Intl.message(
      'Upcoming',
      name: 'kUpcoming',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get kCompleted {
    return Intl.message(
      'Completed',
      name: 'kCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get kPending {
    return Intl.message(
      'Pending',
      name: 'kPending',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get kCancelled {
    return Intl.message(
      'Cancelled',
      name: 'kCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Immediate Parking`
  String get kImmediateParking {
    return Intl.message(
      'Immediate Parking',
      name: 'kImmediateParking',
      desc: '',
      args: [],
    );
  }

  /// `Park now`
  String get kParkNow {
    return Intl.message(
      'Park now',
      name: 'kParkNow',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Parking`
  String get kScheduleParking {
    return Intl.message(
      'Schedule Parking',
      name: 'kScheduleParking',
      desc: '',
      args: [],
    );
  }

  /// `Schedule your parking`
  String get kScheduleYourParking {
    return Intl.message(
      'Schedule your parking',
      name: 'kScheduleYourParking',
      desc: '',
      args: [],
    );
  }

  /// `للغة العربية`
  String get kSwitchLanguage {
    return Intl.message(
      'للغة العربية',
      name: 'kSwitchLanguage',
      desc: '',
      args: [],
    );
  }

  /// `All rights reserved`
  String get kAllRightsReserved {
    return Intl.message(
      'All rights reserved',
      name: 'kAllRightsReserved',
      desc: '',
      args: [],
    );
  }

  /// `version`
  String get kVersion {
    return Intl.message(
      'version',
      name: 'kVersion',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get kSupport {
    return Intl.message(
      'Support',
      name: 'kSupport',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get kPrivacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'kPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Subscription purchased successfully`
  String get kSubscriptionSuccess {
    return Intl.message(
      'Subscription purchased successfully',
      name: 'kSubscriptionSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No bookings`
  String get kNoBookings {
    return Intl.message(
      'No bookings',
      name: 'kNoBookings',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this booking?`
  String get kAreYouSureTicket {
    return Intl.message(
      'Are you sure you want to cancel this booking?',
      name: 'kAreYouSureTicket',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this car?`
  String get kAreYouSureCar {
    return Intl.message(
      'Are you sure you want to delete this car?',
      name: 'kAreYouSureCar',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this card?`
  String get kAreYouSureCard {
    return Intl.message(
      'Are you sure you want to delete this card?',
      name: 'kAreYouSureCard',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this notification?`
  String get kAreYouSureNotification {
    return Intl.message(
      'Are you sure you want to delete this notification?',
      name: 'kAreYouSureNotification',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to clear notifications?`
  String get kAreYouSureAllNotification {
    return Intl.message(
      'Are you sure you want to clear notifications?',
      name: 'kAreYouSureAllNotification',
      desc: '',
      args: [],
    );
  }

  /// `Add car`
  String get kAddCar {
    return Intl.message(
      'Add car',
      name: 'kAddCar',
      desc: '',
      args: [],
    );
  }

  /// `Add card`
  String get kAddCard {
    return Intl.message(
      'Add card',
      name: 'kAddCard',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get kLoginIntroTitle {
    return Intl.message(
      'Welcome Back!',
      name: 'kLoginIntroTitle',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Request is Pending`
  String get kYourRequestIsPending {
    return Intl.message(
      'Subscription Request is Pending',
      name: 'kYourRequestIsPending',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Request is Declined`
  String get kYourRequestIsDeclined {
    return Intl.message(
      'Subscription Request is Declined',
      name: 'kYourRequestIsDeclined',
      desc: '',
      args: [],
    );
  }

  /// ` is in the past`
  String get kIsPast {
    return Intl.message(
      ' is in the past',
      name: 'kIsPast',
      desc: '',
      args: [],
    );
  }

  /// `Choose car to book parking`
  String get kChooseCarToBook {
    return Intl.message(
      'Choose car to book parking',
      name: 'kChooseCarToBook',
      desc: '',
      args: [],
    );
  }

  /// `Choose car to pay violations`
  String get kChooseCarToPayViolations {
    return Intl.message(
      'Choose car to pay violations',
      name: 'kChooseCarToPayViolations',
      desc: '',
      args: [],
    );
  }

  /// `Choose car to subscribe`
  String get kChooseCarToSubscribe {
    return Intl.message(
      'Choose car to subscribe',
      name: 'kChooseCarToSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get kCarColor {
    return Intl.message(
      'Color',
      name: 'kCarColor',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get kCarYear {
    return Intl.message(
      'Year',
      name: 'kCarYear',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any violations`
  String get kNoViolations {
    return Intl.message(
      'You don\'t have any violations',
      name: 'kNoViolations',
      desc: '',
      args: [],
    );
  }

  /// `I accept the terms and conditions`
  String get kAcceptTerms {
    return Intl.message(
      'I accept the terms and conditions',
      name: 'kAcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `You must accept the terms and conditions to proceed`
  String get kYouMustAcceptTerms {
    return Intl.message(
      'You must accept the terms and conditions to proceed',
      name: 'kYouMustAcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// ` - without spaces`
  String get kNoSpaces {
    return Intl.message(
      ' - without spaces',
      name: 'kNoSpaces',
      desc: '',
      args: [],
    );
  }

  /// `Subscriptions`
  String get kSubscriptions {
    return Intl.message(
      'Subscriptions',
      name: 'kSubscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Approved`
  String get kApproved {
    return Intl.message(
      'Approved',
      name: 'kApproved',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get kRejected {
    return Intl.message(
      'Rejected',
      name: 'kRejected',
      desc: '',
      args: [],
    );
  }

  /// `No Notifications`
  String get kNoNotifications {
    return Intl.message(
      'No Notifications',
      name: 'kNoNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get kMyNotifications {
    return Intl.message(
      'Notifications',
      name: 'kMyNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Seen`
  String get kUpdateSeen {
    return Intl.message(
      'Seen',
      name: 'kUpdateSeen',
      desc: '',
      args: [],
    );
  }

  /// `Purchase Parking`
  String get kPurchaseParking {
    return Intl.message(
      'Purchase Parking',
      name: 'kPurchaseParking',
      desc: '',
      args: [],
    );
  }

  /// `Book with Balance`
  String get kBookUsingBalance {
    return Intl.message(
      'Book with Balance',
      name: 'kBookUsingBalance',
      desc: '',
      args: [],
    );
  }

  /// `Book with Payment`
  String get kBookUsingCard {
    return Intl.message(
      'Book with Payment',
      name: 'kBookUsingCard',
      desc: '',
      args: [],
    );
  }

  /// `Enter Payment Details`
  String get kEnterPaymentDetails {
    return Intl.message(
      'Enter Payment Details',
      name: 'kEnterPaymentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get kTermsConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'kTermsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Purchased on`
  String get kPurchaseDate {
    return Intl.message(
      'Purchased on',
      name: 'kPurchaseDate',
      desc: '',
      args: [],
    );
  }

  /// `Valid until`
  String get kExpiryDate {
    return Intl.message(
      'Valid until',
      name: 'kExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `My Packages`
  String get kMyPackages {
    return Intl.message(
      'My Packages',
      name: 'kMyPackages',
      desc: '',
      args: [],
    );
  }

  /// `Social login cancelled by user`
  String get kLoginCancelledByUser {
    return Intl.message(
      'Social login cancelled by user',
      name: 'kLoginCancelledByUser',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}