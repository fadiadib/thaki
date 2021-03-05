/// URIs
// Root API uri
const String kRootURL = 'https://admin.thaki.app/api';
// Check server
const String kCheckAPI = '$kRootURL/check';

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
