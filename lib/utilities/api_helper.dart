import 'package:meta/meta.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

import 'package:thaki/utilities/network_helper.dart';

/// Thank API methods return json maps
class TkAPIHelper {
  static TkNetworkHelper _network = new TkNetworkHelper();

  /// Check server API
  /// Returns user_token and success or failure
  Future<Map> checkServer({
    @required String platform,
    @required String version,
  }) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: 'Server error',
        kDataTag: {
          kUpgradeTag: false,
        },
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kCheckAPI,
      params: {
        kVersionTag: version,
        kPlatformTag: platform,
      },
    );
  }

  /// User login API
  /// Returns user_token and success or failure
  Future<Map> login({
    @required List<Map<String, dynamic>> fields,
    @required String fbToken,
  }) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: '',
        kDataTag: {
          kUserTokenTag: '12345',
          kUserNameTag: 'John Doe',
          kUserEmailTag: 'john.doe@email.com',
          kUserPhoneTag: '01200000000',
          kUserCarsTag: [
            {
              kCarIdTag: 0,
              kCarNameTag: 'My First Car',
              kCarLicenseTag: 'ABC 123',
              kCarMakeTag: 'BMW',
              kCarModelTag: '116i',
              kCarStateTag: 'Saudi Arabia',
              kCarPreferredTag: true,
            },
            {
              kCarIdTag: 1,
              kCarNameTag: 'My Second Car',
              kCarLicenseTag: 'DEF 456',
              kCarMakeTag: 'Mercedes',
              kCarModelTag: 'C Class',
              kCarStateTag: 'Qatar',
              kCarPreferredTag: false,
            },
          ],
          kUserCardsTag: [
            {
              kCardIdTag: 0,
              kCardNameTag: 'My Visa',
              kCardHolderTag: 'John C. Doe',
              kCardNumberTag: '1234567890123456',
              kCardExpiryTag: '11/23',
              kCardCVVTag: '123',
              kCardPreferredTag: true,
              kCardTypeTag: 0,
              kCardBrandPathTag:
                  'https://www.pngfind.com/pngs/m/81-810053_visa-logo-png-transparent-svg-vector-freebie-supply.png',
            },
            {
              kCardIdTag: 1,
              kCardNameTag: 'My Mastercard',
              kCardHolderTag: 'Hane Doe',
              kCardNumberTag: '0987654321098765',
              kCardExpiryTag: '12/26',
              kCardCVVTag: '321',
              kCardPreferredTag: false,
              kCardTypeTag: 1,
              kCardBrandPathTag:
                  'https://w7.pngwing.com/pngs/924/607/png-transparent-mastercard-credit-card-business-debit-card-logo-mastercard-text-service-orange.png',
            },
          ]
        },
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kLoginAPI,
      params: {
        kInfoFieldsTag: fields,
        kUserFbTokenTag: fbToken,
      },
    );
  }

  /// Load tickets API
  Future<Map> loadTickets({
    @required String userToken,
  }) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: '',
        kDataTag: [
          {
            kCarLicenseTag: 'ABC 123',
            kTicketStartTag: '2021-04-01 09:30:00',
            kTicketEndTag: '2021-04-02 09:30:00',
          },
          {
            kCarLicenseTag: 'DEF 456',
            kTicketStartTag: '2021-05-01 10:00:00',
            kTicketEndTag: '2021-05-01 10:30:00',
          },
        ],
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kLoadTicketsAPI,
      params: {
        kUserTokenTag: userToken,
      },
    );
  }

  /// Load user balance API
  Future<Map> loadBalance({
    @required String userToken,
  }) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: '',
        kDataTag: {
          kBalancePointsTag: 30,
          kBalanceValidityTag: '2022-12-31 00:00:00'
        },
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kLoadBalanceAPI,
      params: {
        kUserTokenTag: userToken,
      },
    );
  }

  /// Load packages API
  Future<Map> loadPackages() async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: '',
        kDataTag: [
          {
            kPackagePointsTag: 30,
            kPackagePriceTag: 60.0,
            kPackageValidityTag: 30,
            kPackageDetailsTag:
                'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras mattis consectetur purus sit amet fermentum.\n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. '
          },
          {
            kPackagePointsTag: 60,
            kPackagePriceTag: 120.0,
            kPackageValidityTag: 30,
            kPackageDetailsTag:
                'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras mattis consectetur purus sit amet fermentum.\n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. '
          },
          {
            kPackagePointsTag: 120,
            kPackagePriceTag: 240.0,
            kPackageValidityTag: 30,
            kPackageDetailsTag:
                'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cras mattis consectetur purus sit amet fermentum.\n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras justo odio, dapibus ac facilisis in, egestas eget quam. '
          }
        ],
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kLoadPackagesAPI,
      params: {},
    );
  }

  /// Purchase package API
  Future<Map> purchasePackage({TkPackage package, TkCredit card}) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: 'Cannot purchase package',
        kDataTag: {},
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kPurchasePackageAPI,
      params: {
        kPackageIdTag: package.id,
        kCardIdTag: card.id,
      },
    );
  }

  /// Load disclaimer API
  Future<Map> loadPermitDisclaimer() async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: '',
        kDataTag: {
          kPermitDisclaimerTag:
              'Donec ullamcorper nulla non metus auctor fringilla. Etiam porta sem malesuada magna mollis euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Maecenas sed diam eget risus varius blandit sit amet non magna. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis vestibulum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Maecenas sed diam eget risus varius blandit sit amet non magna.\n\nCras mattis consectetur purus sit amet fermentum. Donec sed odio dui. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        },
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kLoadPermitDisclaimerAPI,
      params: {},
    );
  }

  /// Apply for resident permit API
  Future<Map> applyResidentPermit(TkPermit permit) async {
    //////////////////////////////////////////////////////////
    // Temporary code for debug purposes
    if (kDemoMode) {
      await Future.delayed(Duration(seconds: 1));

      return {
        kStatusTag: kSuccessCode,
        kErrorMessageTag: 'Cannot purchase package',
        kDataTag: {},
      };
    }
    //////////////////////////////////////////////////////////

    return await _network.getData(
      url: kApplyResidentPermitAPI,
      params: {
        kPermitName: permit.name,
        kPermitPhone: permit.phone,
        kPermitEmail: permit.email,
        kPermitsDocuments: permit.documents,
      },
    );
  }

  /// Load violations API
  Future<Map> loadViolations(TkCar car) async {
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
        kCarIdTag: car.id,
      },
    );
  }

  /// Purchase package API
  Future<Map> payViolations(
      {List<TkViolation> violations, TkCredit card}) async {
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
        kViolationIdTag: ids,
        kCardIdTag: card.id,
      },
    );
  }
}
