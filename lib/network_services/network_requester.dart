import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ostad_flutter_batch_one/main.dart';
import 'package:ostad_flutter_batch_one/utils/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import '../screens/login.dart';

class NetworkRequester {
  /// get method
  Future getRequest(String url) async {
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
          'token': UserData.token ?? ''
        },
      );
      if (response.statusCode == 200) {
        Logger().i(jsonDecode(response.body));
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        final sharedPrefs = await SharedPreferences.getInstance();
        sharedPrefs.clear();
        Navigator.pushAndRemoveUntil(
            MyApp.navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
      } else {
        Logger().e('Request failed');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  /// post method
  Future postRequest(String url, Map<String, String> body) async {
    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            'token': UserData.token ?? ''
          },
          body: jsonEncode(body));
      Logger().i(response.statusCode);
      Logger().i(jsonDecode(response.body));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        final sharedPrefs = await SharedPreferences.getInstance();
        sharedPrefs.clear();
        Navigator.pushAndRemoveUntil(
            MyApp.navigatorKey.currentState!.context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
      } else {
        Logger().e('Request failed');
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
