import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ostad_flutter_batch_one/screens/login.dart';

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

  void goToLoginScreen() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()), (
          route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/background.svg', height: MediaQuery
              .of(context)
              .size
              .height, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,),
          Center(
            child: SvgPicture.asset('assets/images/logo.svg', width: 150, fit: BoxFit.scaleDown),
          )
        ],
      ),
    );
  }
}
