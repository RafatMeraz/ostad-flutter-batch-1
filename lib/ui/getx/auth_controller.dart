import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/data/network_utils.dart';
import 'package:ostad_flutter_batch_one/data/urls.dart';

import '../../main.dart';
import '../screens/email_auth_screen.dart';

class AuthController extends GetxController {
  bool authState = false;
  bool sendVerificationCodeToEmailInProgress = false;

  void redirectUnAuthenticatedUser() {
    Navigator.push(
      CraftyBayApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const EmailAuthScreen(),
      ),
    );
  }

  bool checkAuthState() {
    if (!authState) {
      redirectUnAuthenticatedUser();
      return false;
    }
    return true;
  }
  
  Future<bool> sendVerificationCodeToEmail(String email) async {
    sendVerificationCodeToEmailInProgress = true;
    update();
    final response = await NetworkUtils().getMethod(Urls.sendOtpToEmail(email));
    sendVerificationCodeToEmailInProgress = false;
    update();
    if (response != null && response['msg'] == 'success') {
      return true;
    } else {
      return false;
    }
  }
}