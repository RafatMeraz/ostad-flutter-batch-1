import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/widgets/background_image.dart';
import 'package:ostad_flutter_batch_one/widgets/decorations_styles.dart';
import 'package:ostad_flutter_batch_one/widgets/reusable_elevated_button.dart';
import 'package:ostad_flutter_batch_one/widgets/text_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
              const Text('Join Us', style: pageTitleTextStyle),
              const SizedBox(height: 16),
              TextField(
                decoration: textFieldInputDecoration('Email'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: textFieldInputDecoration('First name'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: textFieldInputDecoration('Last name'),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: textFieldInputDecoration('Mobile'),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: textFieldInputDecoration('Password'),
              ),
              const SizedBox(height: 16),
              ReusableElevatedButton(onTap: () {}),
              const SizedBox(height: 16),
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
