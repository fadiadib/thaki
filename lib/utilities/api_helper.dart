import 'package:meta/meta.dart';

import 'package:thaki/globals/index.dart';

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
              kCarNameTag: 'My First Car',
              kCarLicenseTag: 'ABC 123',
              kCarMakeTag: 'BMW',
              kCarModelTag: '116i',
              kCarStateTag: 'Saudi Arabia',
              kCarPreferredTag: true,
            },
            {
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
          },
          {
            kPackagePointsTag: 60,
            kPackagePriceTag: 120.0,
            kPackageValidityTag: 30,
          },
          {
            kPackagePointsTag: 120,
            kPackagePriceTag: 240.0,
            kPackageValidityTag: 30,
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
}
