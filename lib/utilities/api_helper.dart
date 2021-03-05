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
    return await _network.getData(
      url: kCheckAPI,
      params: {
        kVersionTag: version,
        kPlatformTag: platform,
      },
    );
  }
}
