import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ostad_flutter_batch_one/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login.dart';

class NetworkRequester {
  /// get method
  Future getRequest(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Request failed');
      }
    } catch (e) {
      print(e);
    }
  }

  /// post method
  Future postRequest(String url, Map<String, String> body) async {
    try {
      http.Response response =
          await http.post(Uri.parse(url),
              headers: {"Content-type": "application/json", "Accept": "application/json"},
              body: jsonEncode(body));
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
        print('Request failed');
      }
    } catch (e) {
      print(e);
    }
  }
}
