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
        kErrorMessageTag: 'Incorrect Username or Password',
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
              kCarStateTag: 'Saudi Arabia'
            },
            {
              kCarNameTag: 'My Second Car',
              kCarLicenseTag: 'dEF 456',
              kCarMakeTag: 'Mercedes',
              kCarModelTag: 'C Class',
              kCarStateTag: 'Qatar'
            },
          ],
          kUserCardsTag: [
            {
              kCardNameTag: 'My Visa',
              kCardHolderTag: 'John C. Doe',
              kCardNumberTag: '1234567890123456',
              kCardExpiryTag: '11/23',
              kCardCVVTag: '123',
              kCardBrandPathTag:
                  'https://www.pngfind.com/pngs/m/81-810053_visa-logo-png-transparent-svg-vector-freebie-supply.png',
            },
            {
              kCardNameTag: 'My Mastercard',
              kCardHolderTag: 'Hane Doe',
              kCardNumberTag: '0987654321098765',
              kCardExpiryTag: '12/26',
              kCardCVVTag: '321',
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
}
