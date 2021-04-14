import 'package:meta/meta.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

import 'package:thaki/utilities/network_helper.dart';

/// Thaki API methods return json maps
class TkAPIHelper {
  static TkNetworkHelper _network = new TkNetworkHelper();

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
      url: kCheckAPI + '?$kVersionTag=$version&$kPlatformTag=$platform',
    );
  }

  /// Load disclaimer API
  Future<Map> loadDisclaimer(
      {@required TkUser user, @required String type}) async {
    return await _network.getData(
      url: kLoadDisclaimerAPI + '?$kDisclaimerType=$type',
      headers: user.toHeader(),
    );
  }

  /// Load states API
  Future<Map> loadStates({@required TkUser user}) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: 'Cannot pay',
        kDataTag: {
          kStatesTag: [
            {
              'id': 1,
              'name_en': 'Saudi Arabia',
              'name_ar': 'المملكة العربية السعودية'
            },
            {'id': 2, 'name_en': 'Bahrain', 'name_ar': 'االبحرين'},
            {'id': 3, 'name_en': 'Kuwait', 'name_ar': 'الكويت'},
            {'id': 4, 'name_en': 'Oman', 'name_ar': 'عُمان'},
            {'id': 5, 'name_en': 'Qatar', 'name_ar': 'قطر'},
            {
              'id': 6,
              'name_en': 'United Arab Emirates',
              'name_ar': 'لإمارات العربية المتحدة'
            },
            {'id': 7, 'name_en': 'Other', 'name_ar': 'أخرى'},
          ]
        }
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kLoadStates,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////////// USER  ///////////////////////////
  /// User register API
  Future<Map> register({@required TkUser user}) async {
    return await _network.postData(
      url: kRegisterAPI,
      params: user.toJson(),
      headers: user.toHeader(),
    );
  }

  /// User login API
  /// Returns user_token and success or failure
  Future<Map> login({@required TkUser user}) async {
    return await _network.postData(
      url: kLoginAPI,
      params: user.toLoginJson(),
      headers: user.toHeader(),
    );
  }

  /// User logout API
  Future<Map> logout({@required TkUser user}) async {
    return await _network.postData(
      url: kLogoutAPI,
      headers: user.toHeader(),
    );
  }

  /// User load profile API
  Future<Map> load({@required TkUser user}) async {
    return await _network.postData(
      url: KLoadAPI,
      headers: user.toHeader(),
    );
  }

  /// User update profile API
  Future<Map> edit({@required TkUser user}) async {
    return await _network.putData(
      url: kEditAPI,
      params: user.toJson(),
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////////// CARS  ///////////////////////////
  /// Get user cars API
  Future<Map> loadCars({@required TkUser user}) async {
    return await _network.getData(
      url: kLoadCarsAPI,
      headers: user.toHeader(),
    );
  }

  /// Add car API
  Future<Map> addCar({@required TkUser user, @required TkCar car}) async {
    return await _network.postData(
      url: kAddCarAPI,
      params: car.toJson(),
      headers: user.toHeader(),
    );
  }

  /// Delete car API
  Future<Map> deleteCar({@required TkUser user, @required TkCar car}) async {
    return await _network.deleteData(
      url: kDeleteCarAPI + '/${car.id}',
      headers: user.toHeader(),
    );
  }

  /// Update car API
  Future<Map> updateCar({@required TkUser user, @required TkCar car}) async {
    return await _network.putData(
      url: kUpdateCarAPI + '/${car.id}',
      params: car.toJson(),
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////////// CARDS ///////////////////////////
  /// Get user cards API
  Future<Map> loadCards({@required TkUser user}) async {
    return await _network.getData(
      url: kLoadCardsAPI,
      headers: user.toHeader(),
    );
  }

  /// Add card API
  Future<Map> addCard({@required TkUser user, @required TkCredit card}) async {
    return await _network.postData(
      url: kAddCardAPI,
      params: card.toJson(),
      headers: user.toHeader(),
    );
  }

  /// Delete card API
  Future<Map> deleteCard(
      {@required TkUser user, @required TkCredit card}) async {
    return await _network.deleteData(
      url: kDeleteCardAPI + '/${card.id}',
      headers: user.toHeader(),
    );
  }

  /// Update card API
  Future<Map> updateCard(
      {@required TkUser user, @required TkCredit card}) async {
    return await _network.putData(
      url: kUpdateCardAPI + '/${card.id}',
      params: card.toJson(),
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  ////////////////////////// Packages /////////////////////////
  /// Load packages API
  Future<Map> loadPackages({@required TkUser user}) async {
    return await _network.getData(
      url: kLoadPackagesAPI,
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
      url: kPurchasePackageAPI,
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
      url: kLoadUserPackagesAPI,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  /////////////////////// SUBSCRIPTIONS ///////////////////////
  /// Apply for resident permit API
  Future<Map> applyForSubscription(
      {@required TkUser user, @required TkPermit permit}) async {
    return await _network.postData(
      url: kApplySubscriptionPermitAPI,
      params: {
        kSubscriberName: permit.name,
        kSubscriberPhone: permit.phone,
        kSubscriberEmail: permit.email,
      },
      headers: user.toHeader(),
      files: permit.toFiles(),
    );
  }

  /// Load all subscriptions API
  Future<Map> loadSubscriptions({@required TkUser user}) async {
    return await _network.getData(
      url: kLoadSubscriptions,
      headers: user.toHeader(),
    );
  }

  /// Load all subscriptions API
  Future<Map> buySubscriptions(
      {@required TkUser user,
      @required TkSubscription subscription,
      @required TkCredit card,
      @required String cvv}) async {
    return await _network.postData(
      url: kBuySubscription,
      params: {
        kSubscriptionIdIdTag: subscription.id.toString(),
        kCardCardIdTag: card.id.toString(),
        kCardCVVTag: cvv,
      },
      headers: user.toHeader(),
    );
  }

  /// Load user subscriptions API
  Future<Map> loadUserSubscriptions({@required TkUser user}) async {
    return await _network.getData(
      url: kLoadUserSubscriptions,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  ////////////////////////// TICKETS //////////////////////////
  /// Load tickets API
  Future<Map> loadTickets({@required TkUser user}) async {
    return await _network.getData(
      url: kLoadTicketsAPI,
      headers: user.toHeader(),
    );
  }

  /// Load tickets QR
  Future<Map> loadQR({@required TkUser user, @required TkTicket ticket}) async {
    return await _network.postData(
      url: kGetParkingQRAPI,
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
      url: kCancelTicketAPI + '/${ticket.id}',
      headers: user.toHeader(),
    );
  }

  /// Reserve parking API
  Future<Map> reserveParking(
      {@required TkUser user,
      @required TkCar car,
      @required DateTime dateTime,
      @required int duration}) async {
    Map<String, dynamic> params = {
      kCarIdIdTad: car.id.toString(),
      kTicketDurationTag: duration.toString(),
    };
    if (dateTime != null)
      params[kTicketStartTag] = dateTime.toString().split('.').first;

    return await _network.postData(
      url: kReserveParkingAPI,
      params: params,
      headers: user.toHeader(),
    );
  }

  /////////////////////////////////////////////////////////////
  ///////////////////////// VIOLATIONS ////////////////////////
  /// Load violations API
  Future<Map> loadViolations(String car) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: '',
        kDataTag: {
          kViolationsTag: [
            {
              kViolationIdTag: 0,
              kViolationDescTag: 'الوقوف في أماكن عبور المشاة كلياَ أو جزئياَ',
              kViolationLocationTag: 'شارع خادم الحرمين الشريفين',
              kViolationDateTimeTag: '2021-01-31 00:00:00',
              kViolationFineTag: '100',
            },
            {
              kViolationIdTag: 1,
              kViolationDescTag: 'الوقوف في أماكن عبور المشاة كلياَ أو جزئياَ',
              kViolationLocationTag: 'شارع خادم الحرمين الشريفين',
              kViolationDateTimeTag: '2021-02-27 00:00:00',
              kViolationFineTag: '50',
            },
            {
              kViolationIdTag: 2,
              kViolationDescTag: 'الوقوف في أماكن عبور المشاة كلياَ أو جزئياَ',
              kViolationLocationTag: 'شارع خادم الحرمين الشريفين',
              kViolationDateTimeTag: '2021-03-12 00:00:00',
              kViolationFineTag: '100',
            },
          ]
        },
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kLoadViolationsAPI,
      params: {
        kCarPlateENTag: car,
      },
    );
  }

  /// Purchase package API
  Future<Map> payViolations(
      {@required List<TkViolation> violations,
      @required TkCredit card,
      @required String cvv}) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: 'Cannot pay',
        kDataTag: {},
      };
    }
    //////////////////////////////////////////////////////////

    List<int> ids = [];
    for (TkViolation violation in violations) {
      ids.add(violation.id);
    }

    return await _network.getData(
      url: kPayViolationsAPI,
      params: {
        kViolationIdsTag: ids,
        kCardCardIdTag: card.id,
        kCardCVVTag: cvv,
      },
    );
  }
}
