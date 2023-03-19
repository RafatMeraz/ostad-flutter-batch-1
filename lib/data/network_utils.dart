import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:http/http.dart';
import 'package:ostad_flutter_batch_one/ui/getx/user_controller.dart';
import 'package:get/get.dart' as gt;

class NetworkUtils {
  UserController userController = gt.Get.put(UserController());

  /// get method for http request
  Future<dynamic> getMethod(String url, {VoidCallback? onUnAuthorize}) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response =
          await get(uri, headers: {'token': userController.userToken ?? ''});
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        }
      } else {
        log('status code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  /// post method for http request
  Future<dynamic> postMethod(String url,
      {VoidCallback? onUnAuthorize, Map<String, String>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await post(uri,
          headers: {'content-type': 'application/json', 'token': ''},
          body: body);
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorize != null) {
          onUnAuthorize();
        }
      } else {
        log('status code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
