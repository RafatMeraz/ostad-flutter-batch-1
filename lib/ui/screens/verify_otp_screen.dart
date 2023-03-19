import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad_flutter_batch_one/ui/getx/auth_controller.dart';
import 'package:ostad_flutter_batch_one/ui/screens/complete_profile_screen.dart';
import 'package:ostad_flutter_batch_one/ui/screens/main_bottom_navigation_bar.dart';
import 'package:ostad_flutter_batch_one/ui/utils/app_colors.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/snackbar_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

import '../widgets/app_elevated_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;

  const VerifyOtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();

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
                  'Enter OTP Code',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'A 4 digits number sent to your email',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFa6a6a6),
                      letterSpacing: 0.5),
                ),
                const SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  controller: _otpTEController,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    selectedColor: AppColors.primaryColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<AuthController>(builder: (authController) {
                  if (authController.verifyOtpInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return AppElevatedButton(
                    onTap: () {
                      authController
                          .verifyOtp(widget.email, _otpTEController.text)
                          .then((result) {
                        if (result) {
                          authController.readProfileDetails().then((value) {
                            if (value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainBottomNavigationBar()),
                                  (route) => false);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CompleteProfileScreen()));
                            }
                          });
                        } else {
                          showSnackBar(
                              context, 'Otp verification failed! Try again.');
                        }
                      });
                    },
                    text: 'Next',
                  );
                }),
                const SizedBox(
                  height: 16,
                ),
                RichText(
                    text: TextSpan(
                        text: 'This code will expire in ',
                        style: const TextStyle(color: Colors.grey),
                        children: [
                      TextSpan(
                          text: '120s',
                          style: TextStyle(color: AppColors.primaryColor))
                    ])),
                const SizedBox(
                  height: 16,
                ),
                TextButton(onPressed: () {}, child: const Text('Resend Code'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
