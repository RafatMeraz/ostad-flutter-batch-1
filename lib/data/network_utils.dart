import 'dart:convert';
import 'dart:developer';
import 'dart:io';
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
      log(body.toString());
      Uri uri = Uri.parse(url);
      final Response response = await post(uri,
          headers: {
            'content-type': 'application/json',
            'token': userController.userToken ?? ''
          },
          body: jsonEncode(body));
      log(response.body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        // if (onUnAuthorize != null) {
        //   onUnAuthorize();
        // }
        if (userController.userToken != null) {
          await userController.logout();
        }
        userController.redirectUnAuthenticatedUser();
      } else {
        log('status code ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
  }


  Future<dynamic> postMethodWithFile(File profilePicture) async {
    var request = MultipartRequest('POST', Uri.parse('urls'));
    request.fields['name'] = 'rafat';
    request.fields['age'] = '50';
    request.fields['address'] = 'sdjfdksjfk';
    final profilePicMultipartFile = await getMultipartFile(profilePicture, 'profile-image');
    request.files.add(profilePicMultipartFile);
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.transform(utf8.decoder).join();
      return jsonDecode(responseData);
    } else {

    }
  }

  Future<MultipartFile> getMultipartFile(File file, String fieldName) async {
    return MultipartFile.fromBytes(fieldName, file.readAsBytesSync(),
        filename: file.path);
  }
}






