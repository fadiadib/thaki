import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:thaki/globals/index.dart';

/// The NetworkHelper class performs GET and POST http requests
/// getData and postData methods take a URL and body parameters
/// they return a parsed json map
class TkNetworkHelper {
  // Method = GET
  Future<Map> getData(
      {@required String url, Map<String, dynamic> params}) async {
    return _performRequest(url: url, bodyParams: params, method: 'GET');
  }

  // Method = POST
  Future<Map> postData(
      {@required String url, Map<String, dynamic> params}) async {
    return _performRequest(url: url, bodyParams: params, method: 'POST');
  }

  // Perform the request
  Future<Map> _performRequest({
    @required String url,
    Map<String, dynamic> bodyParams,
    String method,
  }) async {
    try {
      // Print verbose
      if (kVerboseNetworkMessages) print('$method $url\n$bodyParams');

      // Perform network request
      http.Request request = http.Request(method, Uri.parse(url));
      request.body = jsonEncode(bodyParams);
      http.StreamedResponse response = (await request.send());

      // Check success code
      if (response.statusCode == 200) {
        String rep = await response.stream.bytesToString();

        // Print verbose
        if (kVerboseNetworkMessages) print(rep);

        // Parse json and return map
        return jsonDecode(rep);
      } else {
        // Show error code
        if (kVerboseNetworkMessages)
          print('NETWORK ERROR with code ${response.statusCode}');
        return {
          'status': response.statusCode,
          'error_message': response.reasonPhrase,
          'data': {}
        };
      }
    } catch (e) {
      if (kVerboseNetworkMessages) print('NETWORK EXCEPTION: $e');
      return {'status': 0, 'error_message': e, 'data': {}};
    }
  }
}
