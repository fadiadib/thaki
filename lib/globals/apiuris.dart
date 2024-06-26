/// URIs
// Root API uri
const String kRootURL = '';
const String kRootAPIHandle = 'root_api_url';
const String kBaseHandle = 'base_url';
// APIs URIs
// Authentication
const String kCheckAPI = '$kRootURL/check';
const String kLoginAPI = '$kRootURL/auth/login';
const String kLogoutAPI = '$kRootURL/auth/logout';
const String kRegisterAPI = '$kRootURL/auth/register';
const String KLoadAPI = '$kRootURL/auth/validate';
const String kEditAPI = '$kRootURL/update_profile';
const String kForgotPasswordAPI = '$kRootURL/auth/forgot_password';
const String kResetPasswordAPI = '$kRootURL/auth/reset_password';
const String kSocialAPI = '$kRootURL/auth/social';
const String kLoadUserAttributesAPI = '$kRootURL/user_attributes';
// Cars
const String kLoadCarsAPI = '$kRootURL/cars';
const String kAddCarAPI = '$kRootURL/cars';
const String kDeleteCarAPI = '$kRootURL/cars';
const String kUpdateCarAPI = '$kRootURL/cars';
const String kLoadStatesAPI = '$kRootURL/attributes';
const String kLoadModelsAPI = '$kRootURL/attributes/model';
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
const String kLoadGuestViolationsAPI = '$kRootURL/violations/guest';
const String kLoadAllViolationsAPI = '$kRootURL/violations/list';
// Transactions
const String kTransactionAPI = '$kRootURL/transaction';
const String kGuestTransactionAPI = '$kRootURL/transaction/guest';
const String kTransactionStatusAPI = '$kRootURL/trans/status';
const String kGetTransactionsAPI = '$kRootURL/transactions_details';
// On boarding
const String kOnBoardingAPI = '$kRootURL/onboarding';

/// Network Codes
// Codes
const int kSuccessCode = 200;
const int kSuccessCreationCode = 201;
const int kPendingCode = 202;
const int kDelayedSuccessCode = 203;
const int kErrorCode = 401;
const int kTransErrorCode = 422;
const int kNotFoundErrorCode = 404;

/// JSON tags
// General tags
const String kStatusTag = 'status';
const String kErrorMessageTag = 'errors';
const String kMessageTag = 'message';
const String kDataTag = 'data';
const String kIdTag = 'id';
const String kAmountTag = 'amount';
const String kCreatedAtTag = 'created_at';
// Header tags
const String kAuthTag = 'Authorization';
const String kLangTag = 'X-localization';
const String kFBTokenTag = 'fb_token';
// Check server tags
const String kVersionTag = 'version';
const String kPlatformTag = 'platform';
const String kUpgradeTag = 'upgrade';
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

const String kUserFirstNameTag = 'first_name';
const String kUserMiddleNameTag = 'middle_name';
const String kUserLastNameTag = 'last_name';
const String kUserGenderTag = 'gender';
const String kUserNationalityTag = 'nationality_id';
const String kUserDriverTypeTag = 'user_type_id';

const String kUserEmailTag = 'email';
const String kUserBirthDateTag = 'birth_date';
const String kUserPhoneTag = 'phone';
const String kUserPasswordTag = 'password';
const String kUserConfirmPasswordTag = 'password_confirmation';
const String kUserOldPasswordTag = 'old_password';
const String kUserRememberTag = 'remember_me';
const String kUserFbTokenTag = 'fb_token';
const String kUserCarsTag = 'cars_list';
const String kUserCardsTag = 'card_list';
const String kUserOTPTag = 'otp';
const String kUserApprovedTag = 'is_approved';
const String kUserLangTag = 'lang';
const String kUserSocialTag = 'social';
const String kUserSocialTokenTag = 'social_token';
const String kUserLoginTypeTag = 'login_type';
// Notifications tags
const String kNotificationTag = 'notification';
const String kNotificationIdTag = 'id';
const String kNotificationNIdTag = 'nid';
const String kNotificationTagTag = 'tag';
const String kNotificationDataTag = 'data';
const String kNotificationTitleTag = 'title';
const String kNotificationBodyTag = 'message';
const String kNotificationMessageTag = 'body';
const String kNotificationDataDetailTag = 'n_data';
const String kNotificationDataTypeTag = 'n_type';
const String kNotificationExpiryTag = 'n_expiry';
const String kNotificationSeenTag = 'n_seen';
const String kNotificationDateTag = 'n_date';
const String kNotificationsCount = 'count';
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
const String kTicketIdentifierTag = 'identifier';
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
const String kPackagesListTag = 'packages_list';
const String kPackagesTag = 'packages';
const String kClientPackagesTag = 'client_packages_list';
const String kPackageIdTag = 'id';
const String kPackageNameTag = 'name';
const String kPackagePkgIdTag = 'package_id';
const String kPackagePointsTag = 'amount_of_hours';
const String kUserPackagePoints = 'hours';
const String kPackageRemainingTag = 'remaining_hours';
const String kPackagePriceTag = 'price';
const String kPackageValidityTag = 'expiry_after';
const String kPackageDetailsTag = 'description';
const String kUserPackageStartDateTag = 'start_date';
const String kUserPackageEndDateTag = 'end_date';
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
const String kSubscriptionsListTag = 'subscriptions_list';
const String kSubscriptionsTag = 'subscription';
const String kSubscriptionsClientTag = 'client_subscriptions_list';
const String kSubscriberCarId = 'car_id';
const String kSubscriptionStartDateTag = 'start_date';
const String kSubscriptionEndDateTag = 'end_date';
const String kSubscriptionCreatedAtTag = 'created_at';
// Violations tags
const String kViolationsListTag = 'violations_list';
const String kViolationsTag = 'violations';
const String kViolationIdTag = 'id';
const String kViolationIdsTag = 'ids';
const String kViolationNameTag = 'name';
const String kViolationDateTimeTag = 'datetime';
const String kViolationLocationTag = 'location';
const String kViolationFineTag = 'fine';
const String kViolationCarTag = 'car_plate';
const String kViolationIssueTag = 'issue_no';
const String kViolationStatusTag = 'status'; // 0: Unpaid, 1: Paid, 2: Cancelled
const String kViolationsDetailsTag = 'violations_details';
const String kViolationUnpaidTag = 'unpaid';
const String kViolationPaidTag = 'paid';
const String kViolationCancelledTag = 'cancelled';
// Attributes tags
const String kAttributeIdTag = 'id';
const String kAttributeENameTag = 'name_en';
const String kAttributeANameTag = 'name_ar';
const String kColorHexTag = 'hex';
const String kMakeIdTag = 'make_id';
const String kStatesTag = 'state_list';
const String kMakesTag = 'make_list';
const String kModelsTag = 'model_list';
const String kColorsTag = 'color_list';
const String kNationalitiesTag = 'nationalities_list';
const String kTypesTag = 'user_types_list';
// Transactions
const String kTransactionIdTag = 'transactable_id';
const String kTransactionTypeTag = 'transactable_type';
const String kTransactionCarIdTag = 'car_id';
const String kTransactionIdsTag = 'ids';
const String kTransactionDateTimeTag = 'datetime';
const String kTransactionDurationTag = 'duration';
const String kPaymentLinkTag = 'payment_link';
const String kRedirectLinkTag = 'redirect_link';
const String kSessionIdTag = 'session_id';
const String kTransactionsTag = 'transactions';
// On boarding screens
const String kOnBoardingTag = 'onboarding';
const String kScreenMessageTag = 'message';
const String kScreenImageTag = 'image';
// Ramadan popup
const String kHomePopupCount = 'home_popup';
