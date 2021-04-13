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
  Future<Map> getData({
    @required String url,
    Map<String, dynamic> params,
    Map<String, String> headers,
    List<http.MultipartFile> files,
  }) async {
    return _performRequest(
        url: url,
        bodyParams: params,
        method: 'GET',
        headers: headers,
        files: files);
  }

  // Method = POST
  Future<Map> postData({
    @required String url,
    Map<String, dynamic> params,
    Map<String, String> headers,
    List<http.MultipartFile> files,
  }) async {
    return _performRequest(
        url: url,
        bodyParams: params,
        method: 'POST',
        headers: headers,
        files: files);
  }

  // Method = PUT
  Future<Map> putData({
    @required String url,
    Map<String, dynamic> params,
    Map<String, String> headers,
    List<http.MultipartFile> files,
  }) async {
    return _putRequest(
        url: url,
        bodyParams: params,
        method: 'PUT',
        headers: headers,
        files: files);
  }

  // Method = DELETE
  Future<Map> deleteData({
    @required String url,
    Map<String, String> headers,
    List<http.MultipartFile> files,
  }) async {
    return _deleteRequest(url: url, method: 'DELETE', headers: headers);
  }

  // Perform the request
  Future<Map> _performRequest({
    @required String url,
    Map<String, dynamic> bodyParams,
    String method,
    Map<String, String> headers,
    List<http.MultipartFile> files,
  }) async {
    try {
      // Print verbose
      if (kVerboseNetworkMessages)
        print('$method $url\n$bodyParams\n$headers\n$files');

      // Perform network request
      http.MultipartRequest request =
          http.MultipartRequest(method, Uri.parse(url));
      if (bodyParams != null)
        bodyParams.forEach((key, value) => request.fields[key] = value);
      if (headers != null)
        headers.forEach((key, value) => request.headers[key] = value);
      if (files != null)
        for (http.MultipartFile file in files) {
          request.files.add(file);
        }

      http.StreamedResponse response = (await request.send());

      // Check success code
      String rep = await response.stream.bytesToString();

      // Print verbose
      if (kVerboseNetworkMessages) print(rep);

      // Parse json and return map
      Map result = jsonDecode(rep);
      result[kStatusTag] = response.statusCode;

      return result;
    } catch (e) {
      if (kVerboseNetworkMessages) print('NETWORK EXCEPTION: $e');
      return {'status': 0, 'error_message': e, 'data': {}};
    }
  }

  // Perform the request
  Future<Map> _putRequest({
    @required String url,
    Map<String, dynamic> bodyParams,
    String method,
    Map<String, String> headers,
    List<http.MultipartFile> files,
  }) async {
    try {
      // Print verbose
      if (kVerboseNetworkMessages) print('$method $url\n$bodyParams\n$headers');

      // Perform network request
      http.Response response =
          await http.put(Uri.parse(url), headers: headers, body: bodyParams);
      String rep = response.body.toString();

      // Print verbose
      if (kVerboseNetworkMessages) print(rep);

      // Parse json and return map
      Map result = jsonDecode(rep);
      result[kStatusTag] = response.statusCode;

      return result;
    } catch (e) {
      if (kVerboseNetworkMessages) print('NETWORK EXCEPTION: $e');
      return {'status': 0, 'error_message': e, 'data': {}};
    }
  }

  // Perform the request
  Future<Map> _deleteRequest({
    @required String url,
    String method,
    Map<String, String> headers,
  }) async {
    try {
      // Print verbose
      if (kVerboseNetworkMessages) print('$method $url\n$headers');

      // Perform network request
      http.Response response =
          await http.delete(Uri.parse(url), headers: headers);
      String rep = response.body.toString();

      // Print verbose
      if (kVerboseNetworkMessages) print(rep);

      // Parse json and return map
      Map result = jsonDecode(rep);
      result[kStatusTag] = response.statusCode;

      return result;
    } catch (e) {
      if (kVerboseNetworkMessages) print('NETWORK EXCEPTION: $e');
      return {'status': 0, 'error_message': e, 'data': {}};
    }
  }
}
