import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/screens/set_password_screen.dart';
import 'package:ostad_flutter_batch_one/widgets/background_image.dart';
import 'package:ostad_flutter_batch_one/widgets/reusable_elevated_button.dart';
import 'package:ostad_flutter_batch_one/widgets/text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController pinTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pin Verification', style: pageTitleTextStyle),
              const SizedBox(height: 8),
              Text('A 6 digits pin has been sent to your email',
                  style: subTitleTextStyle),
              const SizedBox(height: 32),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.black,
                    activeColor: Colors.grey,
                    selectedFillColor: Colors.white70,
                    inactiveFillColor: Colors.white),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.white,
                cursorColor: Colors.black,
                enableActiveFill: true,
                controller: pinTEController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                },
                appContext: context,
              ),
              const SizedBox(height: 16),
              ReusableElevatedButton(
                  text: 'Verify',
                  onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SetPasswordScreen()));
              }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have Account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Sign In'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
