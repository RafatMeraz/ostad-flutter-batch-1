import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/ui/screens/splash_screen.dart';
import 'package:get/get.dart';

main() {
  runApp(const CraftyBayApp());
}

class CraftyBayApp extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  const CraftyBayApp({Key? key}) : super(key: key);

  @override
  State<CraftyBayApp> createState() => _CraftyBayAppState();
}

class _CraftyBayAppState extends State<CraftyBayApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: CraftyBayApp.navigatorKey,
      home: const SplashScreen(),
    );
  }
}
