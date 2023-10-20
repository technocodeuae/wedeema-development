import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/errors/custom_error.dart';
import '../../../../core/errors/unauthorized_error.dart';
import '../../../../../../../data/endpoints/endpoints.dart';

class RestClient {
  // instantiate json decoder for json serialization
  final JsonDecoder _decoder = JsonDecoder();

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String path) {
    return http
        .get(Uri.https(AppEndpoints.BASE_URL, path))
        .then(_createResponse);
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String path, {
    Map<String, String>? headers,
    body,
    encoding,
  }) async {
    print('headers is $headers');
    print('body is $body');
    final response = await http.post(
      Uri.parse(AppEndpoints.BASE_URL + path),
      body: jsonEncode(body),
      headers: headers,
      encoding: encoding,
    );
    final String res = response.body;
    final int statusCode = response.statusCode;
    print('statusCode is $statusCode');
    print('res is $res');
    print('response.body is ${response.body}');
    print('response.url is ${response.request?.url}');
    if (statusCode == 401) {
      throw UnauthorizedError(
        message: json.decode(json.encode(response.body))['error']["message_En"],
      );
    }
    if (statusCode < 200 || statusCode > 400) {
      throw CustomError(
        message: 'Error fetching data from server',
        statusCode: statusCode,
      );
    }

    return _decoder.convert(res);
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(String path,
      {Map<String, String>? headers, body, encoding}) {
    return http
        .put(
          Uri.https(AppEndpoints.BASE_URL, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(String path,
      {Map<String, String>? headers, body, encoding}) {
    return http
        .delete(
          Uri.https(AppEndpoints.BASE_URL, path),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Response:------------------------------------------------------------------
  dynamic _createResponse(http.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw CustomError(
        message: 'Error fetching data from server',
        statusCode: statusCode,
      );
    }

    return _decoder.convert(res);
  }
}
