import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad_flutter_batch_one/ui/getx/auth_controller.dart';
import 'package:ostad_flutter_batch_one/ui/screens/verify_otp_screen.dart';
import 'package:get/get.dart';

import '../widgets/app_elevated_button.dart';
import '../widgets/app_textfield_widget.dart';

class EmailAuthScreen extends StatefulWidget {
  const EmailAuthScreen({Key? key}) : super(key: key);

  @override
  State<EmailAuthScreen> createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                    controller: _emailTEController,
                    hintText: 'Email',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<AuthController>(builder: (authController) {
                    if (_authController.sendVerificationCodeToEmailInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AppElevatedButton(
                      onTap: () {
                        _authController
                            .sendVerificationCodeToEmail(
                                _emailTEController.text.trim())
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyOtpScreen(
                                email: _emailTEController.text.trim(),
                              ),
                            ),
                          );
                        });
                      },
                      text: 'Next',
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
