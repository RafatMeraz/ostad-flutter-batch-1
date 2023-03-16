import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../screens/email_auth_screen.dart';

class AuthController extends GetxController {
  bool authState = false;

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
}