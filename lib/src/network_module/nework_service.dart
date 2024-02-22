import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../services/shared_preferences.dart';
import 'api_base.dart';
import 'api_exception.dart';

class NetworkService {

  //General Get Request
  Future<dynamic> getData(
    String url, {
    Map<String, String>? params,
    Map<String, String>? headers,
    bool isToken = true,
  }) async {

    var responseJson;

    var uri = APIBase.baseURL +
        url +
        ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);
    // print(parsedUrl);

    try {
      final response = await http
          .get(
        parsedUrl,
        headers: this.headers(headers, isToken),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return http.Response("Server Time out", 782);
      });
      //  log("RESPONSE ${response.body}");
      // print(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw GeneralError('No Internet Connection|||', '781');

      // return exception;
    } on FormatException {
      // exception =
      throw GeneralError("Something went wrong|||", "781");
      // return exception;
    } on HttpException {
      //exception =
      throw GeneralError("Something went wrong|||", "781");
      // return exception;
    }
    // catch (e) {
    //   log("UNNKOWN ");
    //   //  exception =
    //   throw GeneralError("Something went wrong, Our team has been notified");
    //   // return exception;
    // }
    return responseJson;
  }

  //General Post Request
  Future<dynamic> postData(
    String url,
    dynamic body, {
    Map<String, String>? params,
    Map<String, String>? headers,
    bool isToken = true,
  }) async {
    var responseJson;

    var uri = APIBase.baseURL +
        url +
        ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);

    // print(parsedUrl);

    try {
      final response = await http
          .post(
        parsedUrl,
        body: body,
        headers: this.headers(headers, isToken),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return http.Response("Server Time out", 782);
      });
      responseJson = _returnResponse(response);
      print(response);
    } on SocketException {
      throw GeneralError('No Internet Connection|||', '781');

      // return exception;
    } on FormatException {
      // exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    } on HttpException {
      //exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    }

    return responseJson;
  }

  //General Put Request
  Future<dynamic> putData(
    String url,
    dynamic body, {
    Map<String, String>? params,
    Map<String, String>? headers,
    bool isPresignedUrl = false,
    bool isToken = true,
  }) async {
    var responseJson;
    var uri;
    if (isPresignedUrl) {
      uri = url + ((params != null) ? queryParameters(params) : "");
    } else {
      uri = APIBase.baseURL +
          url +
          ((params != null) ? queryParameters(params) : "");
    }
    var parsedUrl = Uri.parse(uri);

    try {
      final response = await http.put(
        parsedUrl,
        body: body,
        headers: this.headers(headers, isToken),
      );
      if (isPresignedUrl) {
        if (response.statusCode.toString() == "200" ||
            response.statusCode.toString() == "201") {
          responseJson = {"message": "success"};
        }
      } else {
        responseJson = _returnResponse(response);
      }
    } on SocketException {
      throw GeneralError('No Internet Connection|||', '781');

      // return exception;
    } on FormatException {
      // exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    } on HttpException {
      //exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    }
    return responseJson;
  }

  //General Patch Request
  Future<dynamic> patchData(
    String url,
    dynamic body, {
    Map<String, String>? params,
    Map<String, String>? headers,
    bool isToken = true,
  }) async {
    var responseJson;

    var uri = APIBase.baseURL +
        url +
        ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);

    try {
      final response = await http
          .patch(
        parsedUrl,
        body: body,
        headers: this.headers(headers, isToken),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return http.Response("Server Time out", 782);
      });
      responseJson = _returnResponse(response);
    } on SocketException {
      throw GeneralError('No Internet Connection|||', '781');

      // return exception;
    } on FormatException {
      // exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    } on HttpException {
      //exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    }
    return responseJson;
  }

  //General Delete Request
  Future<dynamic> deleteData(
    String url, {
    Map<dynamic, dynamic>? body,
    Map<String, String>? params,
    Map<String, String>? headers,
    bool isTokene = true,
  }) async {
    var responseJson;
    var uri = APIBase.baseURL +
        url +
        ((params != null) ? queryParameters(params) : "");
    var parsedUrl = Uri.parse(uri);
    print(parsedUrl);
    try {
      final response = await http
          .delete(
        parsedUrl,
        body: body,
        headers: this.headers(headers, isTokene),
      )
          .timeout(const Duration(seconds: 35), onTimeout: () {
        return http.Response("Server Time out", 782);
      });
      print(response);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw GeneralError('No Internet Connection|||', '781');

      // return exception;
    } on FormatException {
      // exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    } on HttpException {
      //exception =
      throw GeneralError("Something went wrong, Please try again.|||", "781");
      // return exception;
    }
    return responseJson;
  }

  // Query Parameters
  String queryParameters(Map<String, String>? params) {
    if (params != null) {
      final jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }

  // Customs headers would append here or return the default values
  Map<String, String> headers(Map<String, String>? headers, bool isToken) {
    var header = {
      // HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    if (isToken) {
      if (SharedPreferenceManager.sharedInstance.hasToken()) {
        header.putIfAbsent("Authorization",
            () => "${SharedPreferenceManager.sharedInstance.getToken()}");
      }
    }

    if (headers != null) {
      header.addAll(headers);
    }
    return header;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 203:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(
            response.statusCode, response.body.toString());
      case 401:
        // Block
        throw UnauthorisedException(
            response.statusCode, response.body.toString());
      case 403:
        throw UnauthorisedException(
            response.statusCode, response.body.toString());
      case 404:
        throw NotFoundRequestException(
            response.statusCode, response.body.toString());
      case 408:
        throw RequestTimeOutException(
            response.statusCode, response.body.toString());
      case 422:
        throw UnprocessableContent(
            response.statusCode, response.body.toString());
      case 423:
        // suspend
        throw UnauthorisedException(
            response.statusCode, response.body.toString());
      case 782:
        throw GeneralError(
            '${response.body.toString()}|||', response.statusCode.toString());

      case 503:      
      case 500:
      default:
        throw FetchDataException(response.statusCode, response.body.toString());
    }
  }
}