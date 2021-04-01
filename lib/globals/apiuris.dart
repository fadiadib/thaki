/// URIs
// Root API uri
const String kRootURL = 'https://admin.thaki.app/api';
// APIs
const String kCheckAPI = '$kRootURL/check';
const String kLoginAPI = '$kRootURL/login';
const String kLoadTicketsAPI = '$kRootURL/load_tickets';
const String kLoadBalanceAPI = '$kRootURL/load_balance';
const String kLoadPackagesAPI = '$kRootURL/load_packages';
const String kPurchasePackageAPI = '$kRootURL/purchase_packages';
const String kLoadPermitDisclaimerAPI = '$kRootURL/load_permit_disclaimer';
const String kApplyResidentPermitAPI = '$kRootURL/apply _permit';
const String kLoadViolationsAPI = '$kRootURL/load_violations';
const String kPayViolationsAPI = '$kRootURL/pay_violations';
const String kReserveParkingAPI = '$kRootURL/reserve_parking';

/// Network Codes and tags
// Codes
const int kSuccessCode = 200;
const int kErrorCode = 201;
const int kPendingCode = 202;
const int kDelayedSuccessCode = 203;
// General tags
const String kStatusTag = 'status';
const String kErrorMessageTag = 'error';
const String kDataTag = 'data';
// Check server tags
const String kVersionTag = 'version';
const String kPlatformTag = 'platform';
const String kUpgradeTag = 'upgrade';
// Info fields
// Info fields tags
const String kFormName = 'form_name';
const String kFormAction = 'form_action';
const String kInfoFieldsTag = 'fields';
const String kIFName = 'f_name';
const String kIFTitle = 'f_title';
const String kIFRequired = 'f_required';
const String kIFValue = 'f_value';
const String kIFVisible = 'f_visible';
const String kIFType = 'f_type';
const String kIFValues = 'f_values';
const String kIFLines = 'f_lines';
const String kIFValueId = 'id';
const String kIFValueTitle = 'title';
// User tags
const String kUserTokenTag = 'user_token';
const String kUserNameTag = 'user_name';
const String kUserEmailTag = 'user_email';
const String kUserPhoneTag = 'user_phone';
const String kUserFbTokenTag = 'fb_token';
const String kUserCarsTag = 'user_cars';
const String kUserCardsTag = 'user_cards';
// Notifications tags
const String kNotificationTag = 'notification';
const String kNotificationIdTag = 'id';
const String kNotificationDataTag = 'data';
const String kNotificationTitleTag = 'title';
const String kNotificationBodyTag = 'message';
const String kNotificationMessageTag = 'body';
const String kNotificationDataDetailTag = 'n_data';
const String kNotificationDataTypeTag = 'n_type';
const String kNotificationExpiryTag = 'n_expiry';
const String kNotificationSeenTag = 'n_seen';
const String kNotificationDateTag = 'n_date';
// Car tags
const String kCarIdTag = 'car_id';
const String kCarNameTag = 'car_name';
const String kCarLicenseTag = 'car_license';
const String kCarMakeTag = 'car_make';
const String kCarModelTag = 'car_model';
const String kCarStateTag = 'car_state';
const String kCarPreferredTag = 'car_preferred';
// Card tags
const String kCardIdTag = 'card_id';
const String kCardNameTag = 'card_name';
const String kCardHolderTag = 'card_holder';
const String kCardNumberTag = 'card_number';
const String kCardExpiryTag = 'card_expiry';
const String kCardCVVTag = 'card_cvv';
const String kCardBrandPathTag = 'card_brand_path';
const String kCardPreferredTag = 'card_preferred';
const String kCardTypeTag = 'card_type';
// Booking tags
const String kTicketTag = 'ticket';
const String kTicketIdTag = 'ticket_id';
const String kTicketNameTag = 'ticket_name';
const String kTicketStartTag = 'ticket_start';
const String kTicketEndTag = 'ticket_end';
const String kTicketDurationTag = 'ticket_duration';
const String kTicketCancelledTag = 'ticket_cancelled';
const String kTicketShowCodeTag = 'ticket_show_code';
const String kTicketCodeTag = 'ticket_code';
// Balance tags
const String kBalancePointsTag = 'balance_points';
const String kBalanceValidityTag = 'balance_validity';
// Package tags
const String kPackagePointsTag = 'package_points';
const String kPackagePriceTag = 'package_price';
const String kPackageValidityTag = 'package_validity';
const String kPackageDetailsTag = 'package_details';
const String kPackageIdTag = 'package_id';
// Permit tags
const String kPermitDisclaimerTag = 'permit_disclaimer';
const String kPermitName = 'permit_name';
const String kPermitPhone = 'permit_phone';
const String kPermitEmail = 'permit_email';
const String kPermitsDocuments = 'permit_documents';
// Violations tags
const String kViolationsTag = 'violations';
const String kViolationIdTag = 'violation_id';
const String kViolationDescTag = 'violation_name';
const String kViolationDateTimeTag = 'violation_datetime';
const String kViolationLocationTag = 'violation_location';
const String kViolationFineTag = 'violation_fine';
