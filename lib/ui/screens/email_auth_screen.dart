import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/app_elevated_button.dart';
import '../widgets/app_textfield_widget.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 46,
                ),
                SvgPicture.asset(
                  'assets/images/crafty-bay-logo.svg',
                  width: 120,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Welcome back',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Please enter your email address',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFa6a6a6),
                      letterSpacing: 0.5),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFieldWidget(
                  controller: TextEditingController(),
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 16,
                ),
                AppElevatedButton(
                  onTap: () {},
                  text: 'Next',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
