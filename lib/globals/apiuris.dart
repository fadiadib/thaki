/// URIs
// Root API uri
const String kRootURL = 'https://admin.thaki.app/api';
// APIs
const String kCheckAPI = '$kRootURL/check';
const String kLoginAPI = '$kRootURL/login';

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
const String kCarNameTag = 'car_name';
const String kCarLicenseTag = 'car_license';
const String kCarMakeTag = 'car_make';
const String kCarModelTag = 'car_model';
const String kCarStateTag = 'car_state';
// Card tags
const String kCardNameTag = 'card_name';
const String kCardHolderTag = 'card_holder';
const String kCardNumberTag = 'card_number';
const String kCardExpiryTag = 'card_expiry';
const String kCardCVVTag = 'card_cvv';
const String kCardBrandPathTag = 'card_brand_path';
