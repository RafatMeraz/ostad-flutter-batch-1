import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/ui/screens/splash_screen.dart';

main() {
  runApp(const CraftyBayApp());
}

class CraftyBayApp extends StatelessWidget {
  const CraftyBayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
