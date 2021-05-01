/// URIs
// Root API uri
const String kRootURL = 'http://thaki.aurasystems.xyz/backend/public/api';
// APIs URIs
// Authentication
const String kCheckAPI = '$kRootURL/check';
const String kLoginAPI = '$kRootURL/auth/login';
const String kLogoutAPI = '$kRootURL/auth/logout';
const String kRegisterAPI = '$kRootURL/auth/register';
const String KLoadAPI = '$kRootURL/auth/validate';
const String kEditAPI = '$kRootURL/update_profile';
// Cars
const String kLoadCarsAPI = '$kRootURL/cars';
const String kAddCarAPI = '$kRootURL/cars';
const String kDeleteCarAPI = '$kRootURL/cars';
const String kUpdateCarAPI = '$kRootURL/cars';
const String kLoadStates = '$kRootURL/states';
// Cards
const String kLoadCardsAPI = '$kRootURL/cards';
const String kAddCardAPI = '$kRootURL/cards';
const String kDeleteCardAPI = '$kRootURL/cards';
const String kUpdateCardAPI = '$kRootURL/cards';
// Packages
const String kLoadPackagesAPI = '$kRootURL/packages';
const String kPurchasePackageAPI = '$kRootURL/packages/buy';
const String kLoadUserPackagesAPI = '$kRootURL/packages/client';
// Subscriptions
const String kLoadDisclaimerAPI = '$kRootURL/disclaimer';
const String kLoadDocumentsAPI = '$kRootURL/documents';
const String kApplySubscriptionPermitAPI = '$kRootURL/subscriptions/request';
const String kLoadSubscriptions = '$kRootURL/subscriptions';
const String kBuySubscription = '$kRootURL/subscriptions/buy';
const String kLoadUserSubscriptions = '$kRootURL/subscriptions/client';
// Parking
const String kGetParkingQRAPI = '$kRootURL/booking/qrcode';
const String kLoadTicketsAPI = '$kRootURL/booking';
const String kCancelTicketAPI = '$kRootURL/booking';
const String kReserveParkingAPI = '$kRootURL/booking';
// Violations
const String kLoadViolationsAPI = '$kRootURL/violations'; // 200, 404: empty
const String kPayViolationsAPI = '$kRootURL/violations/pay'; // 201

/// Network Codes and tags
// Codes
const int kSuccessCode = 200;
const int kSuccessCreationCode = 201;
const int kPendingCode = 202;
const int kDelayedSuccessCode = 203;
const int kErrorCode = 401;
// General tags
const String kStatusTag = 'status';
const String kErrorMessageTag = 'errors';
const String kMessageTag = 'message';
const String kDataTag = 'data';
// Header tags
const String kAuthTag = 'Authorization';
const String kLangTag = 'X-localization';
// Check server tags
const String kVersionTag = 'version';
const String kPlatformTag = 'platform';
const String kUpgradeTag = 'upgrade';
// Info fields
// Info fields tags
const String kFormName = 'form_name';
const String kFormNameAR = 'form_name_ar';
const String kFormAction = 'form_action';
const String kFormActionAR = 'form_action_ar';
const String kInfoFieldsTag = 'fields';
const String kIFName = 'f_name';
const String kIFTitle = 'f_title';
const String kIFTitleAR = 'f_title_ar';
const String kIFRequired = 'f_required';
const String kIFValue = 'f_value';
const String kIFVisible = 'f_visible';
const String kIFType = 'f_type';
const String kIFValues = 'f_values';
const String kIFLines = 'f_lines';
const String kIFValueId = 'id';
const String kIFValueTitle = 'title';
// User tags
const String kUserTag = 'user';
const String kUserTokenTag = 'access_token';
const String kUserTokenTypeTag = 'token_type';
const String kUserNameTag = 'name';
const String kUserEmailTag = 'email';
const String kUserBirthDateTag = 'birth_date';
const String kUserPhoneTag = 'phone';
const String kUserPasswordTag = 'password';
const String kUserConfirmPasswordTag = 'password_confirmation';
const String kUserRememberTag = 'remember_me';
const String kUserFbTokenTag = 'fb_token';
const String kUserCarsTag = 'cars_list';
const String kUserCardsTag = 'card_list';
const String kUserOTPTag = 'user_otp';
const String kUserApprovedTag = 'is_approved';
const String kUserLangTag = 'lang';
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
const String kCarTag = 'car';
const String kCarIdTag = 'id';
const String kCarIdIdTad = 'car_id';
const String kCarNameTag = 'car_name';
const String kCarPlateENTag = 'plate_number_en';
const String kCarPlateARTag = 'plate_number_ar';
const String kCarMakeTag = 'make';
const String kCarModelTag = 'model';
const String kCarStateTag = 'state';
const String kCarPreferredTag = 'is_default';
const String kCarColorTag = 'color';
const String kCarYearTag = 'year';
const String kCarApprovedTag = 'is_approved';
// Card tags
const String kCardTag = 'card';
const String kCardIdTag = 'id';
const String kCardCardIdTag = 'card_id';
const String kCardHolderTag = 'card_holder';
const String kCardNumberTag = 'card_number';
const String kCardExpiryTag = 'card_expiry';
const String kCardCVVTag = 'card_cvv';
const String kCardPreferredTag = 'is_default';
const String kCardTypeTag = 'card_type';
// Booking tags
const String kBookingInfoTag = 'booking_info';
const String kBookingsTag = 'booking_list';
const String kUpcomingTicketsTag = 'upcoming';
const String kCompletedTicketsTag = 'completed';
const String kCancelledTicketsTag = 'cancelled';
const String kPendingTicketsTag = 'pending';
const String kTicketTag = 'ticket';
const String kTicketIdTag = 'id';
const String kTicketNameTag = 'ticket_name';
const String kTicketStartTag = 'datetime';
const String kTicketEndTag = 'ticket_end';
const String kTicketDurationTag = 'duration';
const String kTicketCancelledTag = 'cancelled';
const String kTicketShowCodeTag = 'show_qr_time';
const String kTicketCodeTag = 'qr_data';
const String kBookingIdTag = 'booking_id';
const String kBookingQRData = 'qr_data';
const String kBookingQRMessage = 'qr_message';
// Balance tags
const String kClientPackages = 'client_packages_list';
const String kClientPackage = 'client_package';
const String kBalancePointsTag = 'balance_points';
const String kBalanceValidityTag = 'balance_validity';
// Package tags
const String kPackagesTag = 'packages_list';
const String kPackageIdTag = 'id';
const String kPackagePkgIdTag = 'package_id';
const String kPackagePointsTag = 'amount_of_hours';
const String kPackageRemainingTag = 'remaining_hours';
const String kPackagePriceTag = 'price';
const String kPackageValidityTag = 'expiry_after';
const String kPackageDetailsTag = 'description';
// Documents tags
const String kDocumentsTag = 'document_list';
const String kDocumentNameTag = 'name';
const String kDocumentTitleTag = 'title';
const String kDocumentRequiredTag = 'required';
// Subscriptions tags
const String kDisclaimerType = 'type';
const String kDocumentType = 'type';
const String kDisclaimerTag = 'disclaimer';
const String kSubscriberName = 'client_full_name';
const String kSubscriberPhone = 'client_phones';
const String kSubscriberEmail = 'client_email';
const String kSubscriberCardFront = 'id_card_front_img';
const String kSubscriberCardBack = 'id_card_back_img';
const String kSubscriptionIdTag = 'id';
const String kSubscriptionNameTag = 'name';
const String kSubscriptionPriceTag = 'price';
const String kSubscriptionPeriodTag = 'period';
const String kSubscriptionIdIdTag = 'subscription_id';
const String kSubscriptionsTag = 'subscriptions_list';
const String kSubscriberCarId = 'car_id';
// Violations tags
const String kViolationsTag = 'violations_list';
const String kViolationIdTag = 'id';
const String kViolationIdsTag = 'ids';
const String kViolationDescTag = 'name';
const String kViolationDateTimeTag = 'datetime';
const String kViolationLocationTag = 'location';
const String kViolationFineTag = 'fine';
// States tags
const String kStateIdTag = 'id';
const String kStateEName = 'name_en';
const String kStateAName = 'name_ar';
const String kStatesTag = 'state_list';
