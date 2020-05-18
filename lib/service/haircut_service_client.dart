import 'dart:convert' show json;
import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:haircut_delivery/exception/exception.dart';
import 'package:haircut_delivery/model/request_body_parameters.dart';
import 'package:http/http.dart' as http;

class HaircutServiceClient {
  final _host = 'c054facb.ngrok.io';
  // final _host = 'jsonplaceholder.typicode.com';

  // final _contextRoot = 'v1';

  /// Makes an HTTP request using the GET method to [path] with
  /// query parameter(s) [queryParameters]. If [withAccessToken] is true then
  /// an access token will be sent as a bearer token in a header named
  /// `Authorization`.
  Future<dynamic> get(String path,
      {Map<String, String> queryParameters,
      bool withAccessToken = false}) async {
    final uri = Uri.https(_host, '/$path', queryParameters);
    print('haircut ${uri.toString()}');
    var responseJson;
    final headers = await _buildHeaders(withAccessToken: withAccessToken);
    try {
      final response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(null, 'No Internet connection.');
    }
    return responseJson;
  }

  /// Makes an HTTP request using the POST method to [path] with [data]
  /// as a JSON body. If [withAccessToken] is true then an access token
  /// will be as a bearer token in a header named `Authorization`.
  Future<dynamic> post(String path,
      {RequestBodyParameters data, bool withAccessToken = false}) async {
    final uri = Uri.https(_host, '/$path');
    print(uri.toString());
    print(json.encode(data));
    var responseJson;
    final headers = await _buildHeaders(
        withAccessToken: withAccessToken, withContentType: true);
    print('header :: $headers');
    try {
      print('try 0');
      final response = await http.post(uri,
          headers: headers,
          body: data != null ? json.encode(data.toJson()) : null);
      print('response :: $response');
      responseJson = _returnResponse(response);
      print('try');
    } on SocketException {
      print('chath');
      throw FetchDataException(null, 'No Internet connection.');
    }
    return responseJson;
  }

  /// Makes an HTTP request using the POST method to [path] with [data]
  /// as a JSON body. If [withAccessToken] is true then an access token
  /// will be as a bearer token in a header named `Authorization`.
  Future<dynamic> postFormData(String path,
      {RequestBodyParameters data, bool withAccessToken = false}) async {
    var dio = Dio.Dio();
    final uri = Uri.https(_host, '/$path');
    print(uri.toString());
    print(data.toString());
    try {
      final response = await dio.post(
        uri.toString(),
        data: Dio.FormData.fromMap(data.toJson()),
        options: Dio.Options(
            headers: await _buildHeaders(
                withAccessToken: withAccessToken, withContentType: false)),
      );
      switch (response.statusCode) {
        case 200:
          var responseJson = json.decode(response.data.toString());
          print(responseJson);
          return responseJson;
        case 400:
          throw BadRequestException(
              400, _getErrorMessage(response.data.toString()));
        case 401:
        case 403:
          throw UnauthorisedException(
              401, _getErrorMessage(response.data.toString()));
        case 500:
        default:
          throw FetchDataException(null,
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    } on SocketException catch (e) {
      print(e);
      throw FetchDataException(null, 'No Internet connection.');
    } on Exception catch (e) {
      print(e);
      if (e is Dio.DioError) {
        var data = e.response?.data;
        if (data != null && data is Map) {
          var message = data['message'];
          if (message != null) {
            throw FetchDataException(null, message);
          }
        }
      }
      throw FetchDataException(null, 'Something went wrong.');
    }
  }

  /// Makes an HTTP request using the PUT method to [path] with [data]
  /// as a JSON body. If [withAccessToken] is true then an access token
  /// will be as a bearer token in a header named `Authorization`.
  Future<dynamic> put(String path,
      {RequestBodyParameters data, bool withAccessToken = false}) async {
    final uri = Uri.https(_host, '/$path');
    print(uri.toString());
    print(json.encode(data));
    var responseJson;
    final headers = await _buildHeaders(
        withAccessToken: withAccessToken, withContentType: true);
    try {
      print(json.encode(data.toJson()));
      final response = await http.put(uri,
          headers: headers,
          body: data != null ? json.encode(data.toJson()) : null);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(null, 'No Internet connection.');
    }
    return responseJson;
  }

  /// Makes an HTTP request using the DELETE method to [path] with [data]
  /// as a JSON body. If [withAccessToken] is true then an access token
  /// will be as a bearer token in a header named `Authorization`.
  Future<dynamic> delete(String path,
      {RequestBodyParameters data, bool withAccessToken = false}) async {
    final uri = Uri.https(_host, '/$path');
    print(uri.toString());
    var responseJson;
    final headers = await _buildHeaders(
        withAccessToken: withAccessToken, withContentType: true);
    try {
      final response = await http.delete(uri, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException(null, 'No Internet connection.');
    }
    return responseJson;
  }

  /// Builds a set of HTTP headers to be sent in an HTTP request.
  /// If [withAccessToken] is true then an access token will be sent as
  /// a bearer token in a header named 'Authorization'.
  /// If the [withContentType] is true then the `Content-Type` header will be
  /// sent with value `application/json`.
  Future<Map<String, String>> _buildHeaders(
      {bool withAccessToken = false, bool withContentType = false}) async {
    final Map<String, String> headers = {'Accept': 'application/json'};
    if (withContentType) {
      headers.putIfAbsent('Content-Type', () => 'application/json');
    }
    if (withAccessToken) {
      final storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken');
      if (accessToken != null) {
        headers.putIfAbsent('Authorization', () => 'Bearer ' + accessToken);
        print('Authorization: Bearer ' + accessToken);
      }
    }
    return headers;
  }

  /// Returns a decoded [response] JSON or throw an exception.
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body);
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(400, _getErrorMessage(response.body));
      case 401:
      case 403:
        throw UnauthorisedException(401, _getErrorMessage(response.body));
      case 500:
      default:
        throw FetchDataException(null,
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  /// Returns an error message from a JSON string [jsonString] response from web service.
  String _getErrorMessage(String jsonString) {
    final obj = json.decode(jsonString);
    final message = obj['message'];
    return message != null ? message : 'An error occurred.';
  }
}
