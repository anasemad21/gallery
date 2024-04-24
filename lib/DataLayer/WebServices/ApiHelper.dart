import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:galleryapp/DataLayer/WebServices/SharedPrefManager.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:loader_overlay/loader_overlay.dart';



class ApiHandler {
  final String baseUrl = 'https://flutter.prominaagency.com/api/';
  String? token;
  // Map<String, String>? headers;
  http.Client? client;

  static final ApiHandler _instance = ApiHandler._internal();

  factory ApiHandler() {
    return _instance;
  }

  ApiHandler._internal() {
    client = http.Client();
  }



  Future<Map<String, dynamic>?> authorizedPostRequest(
      String url,BuildContext context ,{Map<String, dynamic>? requestData}) async {
    url = baseUrl + url;
    token = SharedPreferencesManager.getString('token').toString();

    log('requestData from apiHelper test '+jsonEncode(requestData));

    try {

      http.Response response = await client!.post(
        Uri.parse(url),
        body:requestData,
      );

      return _handleResponse(response,context);
    }
    catch (e) {

      _handleError(e,context);
    }
  }





  Future<Map<String, dynamic>?> unauthorizedPostRequest(
      String url, Map<String, dynamic> requestData,BuildContext context) async {
    url = baseUrl + url;
    log("req data from unauth"+requestData.toString());
    try {
      http.Response response = await client!.post(
        Uri.parse('https://flutter.prominaagency.com/api/auth/login'),
        body:
        {'email': 'graham.mabel@example.org',
        'password': 'password',}
      );
      log("response data from unaut"+response.toString());
      return _handleResponse(response,context);
    } catch (e) {
      _handleError(e,context);
    }
  }

  Future<Map<String, dynamic>?> authorizedGetRequest(String url,BuildContext context) async {

    context.loaderOverlay.show();
    url = baseUrl + url;
    token=SharedPreferencesManager.getString('token');
    // log("token from authorizedGetRequest "+token.toString());
    try {
      http.Response response = await client!.get(
        Uri.parse(url),
        headers: {'Content-Type':'application/json'},
      );

      // Print the response
      // log("Response status code: ${response.statusCode}");
      // log("Response body: ${response.body}");
      context.loaderOverlay.hide();
      return _handleResponse(response,context);
    } catch (e) {

      _handleError(e,context);
      rethrow;
    }

    ////////////////////////////////////////////////////////////////////////////

  }


  Map<String, dynamic>? _handleResponse(http.Response response,BuildContext context) {
    context.loaderOverlay.hide();
    log("_handleResponse "+response.body);
    if (response.statusCode ==200 ) {
      log("response from _handleResponse::"+response.body);
      return jsonDecode(response.body);
    } else {
      _handleError(
          'Request failed with status ${response.statusCode}: ${response.body}',context);
    }

    // return null;
  }

  void _handleError(dynamic error,BuildContext context) {
    context.loaderOverlay.hide();
    log('API Request Error: $error');
    // ShowToast

    throw Exception("API Request Error: $error");
    // Perform additional error handling logic, such as logging or showing an error message
  }

  void dispose() {
    client!.close();
  }
}