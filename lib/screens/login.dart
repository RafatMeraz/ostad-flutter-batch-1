import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/screens/forgot_password_screen.dart';
import 'package:ostad_flutter_batch_one/screens/main_bottom_nav_bar.dart';
import 'package:ostad_flutter_batch_one/screens/register_screen.dart';
import 'package:ostad_flutter_batch_one/widgets/background_image.dart';
import 'package:ostad_flutter_batch_one/widgets/decorations_styles.dart';
import '../widgets/reusable_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get Started With',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: emailTEController,
                    decoration: textFieldInputDecoration('Email'),
                    validator: (String? text) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passwordTEController,
                    obscureText: true,
                    decoration: textFieldInputDecoration('Password'),
                    validator: (String? text) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ReusableElevatedButton(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) =>
                          const MainBottomNavBar()), (route) => false);
                    },
                  ),
                  const SizedBox(height: 32),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen()));
                          },
                          child: const Text('Forget password?'))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterScreen()));
                          },
                          child: const Text('Sign Up'))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
