
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:galleryapp/DataLayer/WebServices/ApiHelper.dart';
import 'package:galleryapp/DataLayer/WebServices/SharedPrefManager.dart';
import 'package:galleryapp/Models/Response/GeneralResponse.dart';
import 'package:galleryapp/PresentationLayers/Screens/login.dart';
import 'package:galleryapp/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

import 'package:loader_overlay/loader_overlay.dart';

class LoginController{

  static final LoginController _singleton = LoginController._internal();

  factory LoginController() {
    return _singleton;
  }

  LoginController._internal();

  //////////////////////////////////////////////////////
  ApiHandler api=ApiHandler();
  /////////////////////////////////////////////////////
  String? token;
  login(BuildContext context, String email, String password) async {
    log("enter to login controller");
    if (email.isEmpty || password.length < 2 || password.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter a valid email address and password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.red,
        fontSize: 16.0,
      );
      throw Exception("Please enter a valid email address and password");
    }

    try {
      context.loaderOverlay.show();
      dynamic response = await api.unauthorizedPostRequest(
        'auth/login',
        {'email': email, 'password': password},
        context,
      );


      Map<String, dynamic> jsonResponse = response;
      GeneralResponse generalResponse = GeneralResponse.fromJson(jsonResponse);

      if (generalResponse.user != null) {
        SharedPreferencesManager.setString('token', generalResponse.token.toString());
        SharedPreferencesManager.setString('id', generalResponse.user!.id!.toString());
        SharedPreferencesManager.setString('email', generalResponse.user!.name.toString());
        log("in login ${SharedPreferencesManager.getString("token")}");

        GoRouter.of(context).push(AppRouter.kHomeView);
      } else {
        Fluttertoast.showToast(
          msg: "Check Your Inputs",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0,
        );
        throw Exception("Check Your Inputs");
      }
    } on SocketException catch (ex) {
      print("Network error during login: $ex");
      // Handle network error
    } on HttpException catch (ex) {
      print("HTTP error during login: $ex");
      // Handle HTTP error
    } catch (ex) {
      print("Unknown error during login: $ex");
      // Handle other types of errors
    } finally {
      context.loaderOverlay.hide();
    }
  }

  ///////////////////////////////////////////////////////////
  me(BuildContext context) async {
    String? token = SharedPreferencesManager.getString("token");

    if (token != null) {
      try {

        dynamic response = await api.authorizedPostRequest('auth/login', context);
        GeneralResponse generalResponse = GeneralResponse.fromJson(response);

        if (generalResponse.user != null && generalResponse.token != null) {
          _handleSuccessfulAuthentication(context, generalResponse);
        } else {
          _handleAuthenticationFailure(context);
        }
      } catch (error) {
        print("Error during API call: $error");
        _handleAuthenticationFailure(context);
      //
        }
        //
        // finally {
      //   context.loaderOverlay.hide();
      // }
    } else {
      print("Token is null");
      _navigateToLoginPage(context);
    }
  }

  void _navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  void _handleSuccessfulAuthentication(BuildContext context, GeneralResponse generalResponse) {

    // GeneralResponse generalResponse=GeneralResponse.fromJson(generalResponse);
    log("me Response "+jsonEncode(generalResponse));
    log("in me${SharedPreferencesManager.getString("token")}");
    //
    SharedPreferencesManager.setString('token', generalResponse.token.toString());
    SharedPreferencesManager.setString('id', generalResponse.user!.id.toString());
    SharedPreferencesManager.setString('email', generalResponse.user!.email.toString());
    SharedPreferencesManager.setString('email', generalResponse.user!.name.toString());


    GoRouter.of(context).push(AppRouter.kHomeView);
  }

  void _handleAuthenticationFailure(BuildContext context) {
    print("Authentication failed");
    _navigateToLoginPage(context);
    SharedPreferencesManager.remove();
  }


}