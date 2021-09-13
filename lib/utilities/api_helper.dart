import 'package:meta/meta.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/lang_controller.dart';

import 'package:thaki/utilities/network_helper.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

/// Thaki API methods return json maps
class TkAPIHelper {
  static TkNetworkHelper _network = new TkNetworkHelper();
  static String _rootURL;

  /// Gets the root URL from firebase Remote Config,
  /// if the root urL was already fetched it is returned
  /// through a static member _rootURL
  static Future<String> getRootURL() async {
    if (kForceLiveServer) return kDefaultLiveServer;
    if (kForceTestServer) return kDefaultTestServer;

    if (_rootURL != null) return _rootURL;

    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    final defaults = <String, dynamic>{kRootAPIHandle: kDefaultTestServer};
    await remoteConfig.setDefaults(defaults);

    await remoteConfig.fetch(expiration: const Duration(hours: 12));
    await remoteConfig.activateFetched();

    _rootURL = remoteConfig.getString(kRootAPIHandle);
    return _rootURL;
  }

  /// Normalize error method, takes a result json and finds the
  /// error strings and groups them into a paragraph.
  String normalizeError(Map result) {
    String errorMessage = '';
    if (result[kErrorMessageTag] != null) {
      Map errors = result[kErrorMessageTag];
      for (String key in errors.keys) {
        for (String value in errors[key]) errorMessage += value + '\n';
      }
    } else if (result[kMessageTag] != null) {
      errorMessage = result[kMessageTag];
    } else {
      errorMessage = kUnknownError;
    }
    return errorMessage;
  }

  ///////////////////////// GENERAL /////////////////////////
  /// Check server API
  /// Returns user_token and success or failure
  Future<Map> checkServer(
      {@required String platform, @required String version}) async {
    return await _network.getData(
      url: await getRootURL() +
          kCheckAPI +
          '?$kVersionTag=$version&$kPlatformTag=$platform',
    );
  }

  /// Loads on boarding messages and images
  Future<Map> loadOnboarding(
      {@required TkLangController langController}) async {
    return await _network.getData(
      url: await getRootURL() + kOnBoardingAPI,
      headers: langController.toHeader(),
    );
  }

  /// Load disclaimer API
  Future<Map> loadDisclaimer(
      {@required TkUser user, @required String type}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadDisclaimerAPI + '?$kDisclaimerType=$type',
      headers: user.toHeader(),
    );
  }

  /// Load attributes API
  Future<Map> loadAttributes(
      {@required TkLangController langController}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadStatesAPI,
      headers: langController.toHeader(),
    );
  }

  /// Load models API
  Future<Map> loadModels({@required TkUser user, @required int makeId}) async {
    return await _network.getData(
      url: await getRootURL() +
          kLoadModelsAPI +
          '?$kMakeIdTag=${makeId.toString()}',
      headers: user.toHeader(),
    );
  }

  /// Load documents API
  Future<Map> loadDocuments(
      {@required TkUser user, @required String type}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadDocumentsAPI + '?$kDocumentType=$type',
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////// TRANSACTIONS  ///////////////////////
  /// Initialize payment transaction API
  Future<Map> initTransaction({
    @required TkUser user,
    @required String type,
    int id,
    TkCar car,
    DateTime dateTime,
    int duration,
    List<int> ids,
  }) async {
    Map<String, dynamic> params = {kTransactionTypeTag: type};
    if (id != null) params[kTransactionIdTag] = id.toString();
    if (car != null) params[kTransactionCarIdTag] = car.id.toString();
    if (dateTime != null)
      params[kTransactionDateTimeTag] = dateTime.toString().split('.').first;
    if (duration != null) params[kTransactionDurationTag] = duration.toString();
    if (ids != null) params[kTransactionIdTag] = ids.join(',');

    return await _network.postData(
      url: await getRootURL() + kTransactionAPI,
      params: params,
      headers: user.toHeader(),
    );
  }

  Future<Map> initGuestTransaction({
    @required String type,
    TkLangController langController,
    int id,
    TkCar car,
    DateTime dateTime,
    int duration,
    List<int> ids,
  }) async {
    Map<String, dynamic> params = {kTransactionTypeTag: type};
    if (id != null) params[kTransactionIdTag] = id.toString();
    if (car != null) params[kTransactionCarIdTag] = car.id.toString();
    if (dateTime != null)
      params[kTransactionDateTimeTag] = dateTime.toString().split('.').first;
    if (duration != null) params[kTransactionDurationTag] = duration.toString();
    if (ids != null) params[kTransactionIdTag] = ids.join(',');

    return await _network.postData(
      url: await getRootURL() + kGuestTransactionAPI,
      params: params,
      headers: langController.toHeader(),
    );
  }

  /// Check payment transaction status API
  Future<Map> checkTransaction({
    @required TkUser user,
    @required String transactionId,
    @required TkLangController langController,
    bool guest = false,
  }) async {
    return await _network.postData(
      url: await getRootURL() + kTransactionStatusAPI,
      params: {kSessionIdTag: transactionId},
      headers: guest ? langController.toHeader() : user.toHeader(),
    );
  }

  /// Get transactions API
  Future<Map> getTransactions({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kGetTransactionsAPI,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////////// USER  ///////////////////////////
  /// Load user attributes API
  Future<Map> loadUserAttributes() async {
    return await _network.getData(
        url: await getRootURL() + kLoadUserAttributesAPI);
  }

  /// User register API
  Future<Map> register({@required TkUser user}) async {
    return await _network.postData(
      url: await getRootURL() + kRegisterAPI,
      params: await user.toJson(),
      headers: user.toHeader(),
    );
  }

  /// User update profile API
  Future<Map> edit({@required TkUser user}) async {
    return await _network.putData(
      url: await getRootURL() + kEditAPI,
      params: await user.toJson(),
      headers: user.toHeader(),
    );
  }

  /// User login API
  /// Returns user_token and success or failure
  Future<Map> login({@required TkUser user}) async {
    return await _network.postData(
      url: await getRootURL() + kLoginAPI,
      params: await user.toLoginJson(),
      headers: user.toHeader(),
    );
  }

  /// User social login API
  /// Returns user_token and success or failure
  Future<Map> social({@required TkUser user}) async {
    return await _network.postData(
      url: await getRootURL() + kSocialAPI,
      params: await user.toSocialLoginJson(),
      headers: user.toHeader(),
    );
  }

  /// User delete social login API
  Future<Map> deleteSocial({@required TkUser user}) async {
    return await _network.deleteData(
      url: await getRootURL() + kSocialAPI,
      headers: user.toHeader(),
    );
  }

  /// User load profile API
  Future<Map> load({@required TkUser user}) async {
    return await _network.postData(
      url: await getRootURL() + KLoadAPI,
      params: await user.toLoadJson(),
      headers: user.toHeader(),
    );
  }

  /// User logout API
  Future<Map> logout({@required TkUser user}) async {
    return await _network.postData(
      url: await getRootURL() + kLogoutAPI,
      headers: user.toHeader(),
    );
  }

  /// Forgot password API - Sends OTP
  /// Returns success or failure
  Future<Map> forgotPassword({@required TkUser user}) async {
    return await _network.postData(
      url: await getRootURL() + kForgotPasswordAPI,
      params: await user.toForgotPasswordJson(),
      headers: user.toHeader(),
    );
  }

  /// Reset password API - Confirm OTP
  /// Returns success or failure
  Future<Map> resetPassword({@required TkUser user}) async {
    return await _network.postData(
      url: await getRootURL() + kResetPasswordAPI,
      params: await user.toOTPJson(),
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////////// CARS  ///////////////////////////
  /// Get user cars API
  Future<Map> loadCars({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadCarsAPI,
      headers: user.toHeader(),
    );
  }

  /// Add car API
  Future<Map> addCar({@required TkUser user, @required TkCar car}) async {
    return await _network.postData(
      url: await getRootURL() + kAddCarAPI,
      params: car.toJson(),
      headers: user.toHeader(),
    );
  }

  /// Delete car API
  Future<Map> deleteCar({@required TkUser user, @required TkCar car}) async {
    return await _network.deleteData(
      url: await getRootURL() + kDeleteCarAPI + '/${car.id}',
      headers: user.toHeader(),
    );
  }

  /// Update car API
  Future<Map> updateCar({@required TkUser user, @required TkCar car}) async {
    return await _network.putData(
      url: await getRootURL() + kUpdateCarAPI + '/${car.id}',
      params: car.toJson(),
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////////// CARDS ///////////////////////////
  /// Get user cards API
  Future<Map> loadCards({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadCardsAPI,
      headers: user.toHeader(),
    );
  }

  /// Add card API
  Future<Map> addCard({@required TkUser user, @required TkCredit card}) async {
    return await _network.postData(
      url: await getRootURL() + kAddCardAPI,
      params: card.toJson(),
      headers: user.toHeader(),
    );
  }

  /// Delete card API
  Future<Map> deleteCard(
      {@required TkUser user, @required TkCredit card}) async {
    return await _network.deleteData(
      url: await getRootURL() + kDeleteCardAPI + '/${card.id}',
      headers: user.toHeader(),
    );
  }

  /// Update card API
  Future<Map> updateCard(
      {@required TkUser user, @required TkCredit card}) async {
    return await _network.putData(
      url: await getRootURL() + kUpdateCardAPI + '/${card.id}',
      params: card.toJson(),
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  ////////////////////////// Packages /////////////////////////
  /// Load packages API
  Future<Map> loadPackages({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadPackagesAPI,
      headers: user.toHeader(),
    );
  }

  /// Purchase package API
  Future<Map> purchasePackage({
    @required TkUser user,
    @required TkPackage package,
    @required TkCredit card,
    @required String cvv,
  }) async {
    return await _network.postData(
      url: await getRootURL() + kPurchasePackageAPI,
      params: {
        kPackagePkgIdTag: package.id.toString(),
        kCardCardIdTag: card.id.toString(),
        kCardCVVTag: cvv,
      },
      headers: user.toHeader(),
    );
  }

  /// Load user balance API
  Future<Map> loadUserPackages({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadUserPackagesAPI,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////// SUBSCRIPTIONS ///////////////////////
  /// Apply for resident permit API
  Future<Map> applyForSubscription({
    @required TkUser user,
    @required TkPermit permit,
    @required TkCar car,
  }) async {
    return await _network.postData(
      url: await getRootURL() + kApplySubscriptionPermitAPI,
      params: {
        kSubscriberName: permit.name,
        kSubscriberPhone: permit.phone,
        kSubscriberEmail: permit.email,
        kSubscriberCarId: car.id.toString(),
      },
      headers: user.toHeader(),
      files: permit.toFiles(),
    );
  }

  /// Load all subscriptions API
  Future<Map> loadSubscriptions({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadSubscriptions,
      headers: user.toHeader(),
    );
  }

  /// Load all subscriptions API
  Future<Map> buySubscriptions(
      {@required TkUser user,
      @required TkSubscription subscription,
      @required TkCredit card,
      @required TkCar car,
      @required String cvv}) async {
    return await _network.postData(
      url: await getRootURL() + kBuySubscription,
      params: {
        kSubscriptionIdIdTag: subscription.id.toString(),
        kCardCardIdTag: card.id.toString(),
        kCardCVVTag: cvv,
        kSubscriberCarId: car.id.toString(),
      },
      headers: user.toHeader(),
    );
  }

  /// Load user subscriptions API
  Future<Map> loadUserSubscriptions({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadUserSubscriptions,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  ////////////////////////// TICKETS //////////////////////////
  /// Load tickets API
  Future<Map> loadTickets({@required TkUser user}) async {
    return await _network.getData(
      url: await getRootURL() + kLoadTicketsAPI,
      headers: user.toHeader(),
    );
  }

  /// Load tickets QR
  Future<Map> loadQR({@required TkUser user, @required TkTicket ticket}) async {
    return await _network.postData(
      url: await getRootURL() + kGetParkingQRAPI,
      params: {
        kBookingIdTag: ticket.id.toString(),
        kBookingQRData: '1',
      },
      headers: user.toHeader(),
    );
  }

  /// Cancel ticket
  Future<Map> cancelTicket(
      {@required TkUser user, @required TkTicket ticket}) async {
    return await _network.deleteData(
      url: await getRootURL() + kCancelTicketAPI + '/${ticket.id}',
      headers: user.toHeader(),
    );
  }

  /// Reserve parking API
  Future<Map> reserveParking({
    @required TkUser user,
    @required TkCar car,
    @required DateTime dateTime,
    @required int duration,
    TkCredit card,
  }) async {
    Map<String, dynamic> params = {
      kCarIdIdTad: car.id.toString(),
      kTicketDurationTag: duration.toString(),
    };
    if (dateTime != null)
      params[kTicketStartTag] = dateTime.toString().split('.').first;
    if (card != null) params[kCardCardIdTag] = card.id.toString();

    return await _network.postData(
      url: await getRootURL() + kReserveParkingAPI,
      params: params,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  ///////////////////////// VIOLATIONS ////////////////////////
  /// Load violations API
  Future<Map> loadViolations(String licensePlate, TkUser user,
      {bool all = false}) async {
    return await _network.getData(
      url: !all
          ? await getRootURL() +
              kLoadViolationsAPI +
              '?' +
              kCarPlateENTag +
              '=' +
              licensePlate
          : await getRootURL() +
              kLoadAllViolationsAPI +
              '?' +
              kCarPlateENTag +
              '=' +
              licensePlate,
      params: {kCarPlateENTag: licensePlate},
      headers: user.toHeader(),
    );
  }

  /// Load violations API without user token
  Future<Map> loadViolationsWithoutToken(
      String licensePlate, TkLangController langController) async {
    return await _network.getData(
      url: await getRootURL() +
          kLoadGuestViolationsAPI +
          '?' +
          kCarPlateENTag +
          '=' +
          licensePlate,
      params: {kCarPlateENTag: licensePlate},
      headers: langController.toHeader(),
    );
  }

  /// Purchase package API
  Future<Map> payViolations(
      {@required List<TkViolation> violations,
      @required TkCredit card,
      @required String cvv}) async {
    List<int> ids = [];
    for (TkViolation violation in violations) {
      ids.add(violation.id);
    }

    return await _network.postData(
      url: await getRootURL() + kPayViolationsAPI,
      params: {
        kViolationIdsTag: ids,
        kCardCardIdTag: card.id,
        kCardCVVTag: cvv,
      },
    );
  }
}
