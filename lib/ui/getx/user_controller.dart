import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/data/models/user_details.dart';
import 'package:ostad_flutter_batch_one/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/email_auth_screen.dart';

class UserController extends GetxController {
  UserDetails? userDetails;
  String? userToken;

  Future<void> saveUserDetails(UserDetails uDetails) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user', jsonEncode(uDetails.toJson()));
    userDetails = uDetails;
  }

  Future<void> saveUserToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    userToken = token;
  }

  Future<void> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('token');
  }

  Future<void> getUserDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user = sharedPreferences.getString('user') ?? '';
    userDetails = UserDetails.fromJson(jsonDecode(user));
  }

  void redirectUnAuthenticatedUser() {
    Navigator.push(
      CraftyBayApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const EmailAuthScreen(),
      ),
    );
  }

  bool checkAuthState() {
    if (userToken == null) {
      redirectUnAuthenticatedUser();
      return false;
    }
    return true;
  }

  Future<void> logout() async {
    userToken = null;
    userDetails = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
