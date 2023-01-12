import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad_flutter_batch_one/screens/login.dart';
import 'package:ostad_flutter_batch_one/screens/main_bottom_nav_bar.dart';
import 'package:ostad_flutter_batch_one/utils/user_data.dart';
import 'package:ostad_flutter_batch_one/widgets/background_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      goToLoginScreen();
    });
  }

  void goToLoginScreen() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final String? result = sharedPrefs.getString('token');
    if (result != null) {
      UserData.token = result;
      UserData.firstName = sharedPrefs.getString('firstName');
      UserData.lastName = sharedPrefs.getString('lastName');
      UserData.email = sharedPrefs.getString('email');

      Future.delayed(const Duration(seconds: 1)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainBottomNavBar()),
                (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Center(
          child: SvgPicture.asset('assets/images/logo.svg',
              width: 150, fit: BoxFit.scaleDown),
        ),
      ),
    );
  }
}
