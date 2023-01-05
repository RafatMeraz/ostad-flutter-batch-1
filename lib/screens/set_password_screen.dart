import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/screens/register_screen.dart';
import 'package:ostad_flutter_batch_one/widgets/background_image.dart';
import 'package:ostad_flutter_batch_one/widgets/decorations_styles.dart';
import 'package:ostad_flutter_batch_one/widgets/reusable_elevated_button.dart';
import 'package:ostad_flutter_batch_one/widgets/text_styles.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Set Password', style: pageTitleTextStyle),
              const SizedBox(height: 8),
              Text(
                'Minimum length of password should be more that 8 letters and non-digits',
                style: subTitleTextStyle,
              ),
              const SizedBox(height: 24),
              TextField(
                obscureText: true,
                decoration: textFieldInputDecoration('New Password'),
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: textFieldInputDecoration('Confirm Password'),
              ),
              const SizedBox(height: 24),
              ReusableElevatedButton(
                  text: 'Confirm',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
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
