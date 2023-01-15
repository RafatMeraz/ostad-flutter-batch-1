import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/screens/forgot_password_screen.dart';
import 'package:ostad_flutter_batch_one/screens/main_bottom_nav_bar.dart';
import 'package:ostad_flutter_batch_one/screens/register_screen.dart';
import 'package:ostad_flutter_batch_one/utils/user_data.dart';
import 'package:ostad_flutter_batch_one/widgets/background_image.dart';
import 'package:ostad_flutter_batch_one/widgets/decorations_styles.dart';
import '../network_services/network_requester.dart';
import '../widgets/reusable_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTEController = TextEditingController();
  TextEditingController passwordTEController = TextEditingController();

  final _loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SafeArea(
          child: Form(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _loginForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 32,
                      ),
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
                          if (text?.isEmpty ?? true) {
                            return 'Enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: passwordTEController,
                        obscureText: true,
                        decoration: textFieldInputDecoration('Password'),
                        validator: (String? text) {
                          if (text?.isEmpty ?? true) {
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ReusableElevatedButton(
                        onTap: () async {
                          if (_loginForm.currentState!.validate()) {
                            final result = await NetworkRequester().postRequest(
                                'https://task.teamrabbil.com/api/v1/login',
                                {
                                  "email": emailTEController.text,
                                  "password": passwordTEController.text,
                                });
                            print(result);
                            if (result['status'] == 'success') {
                              final sharedPrefs = await SharedPreferences.getInstance();
                              UserData.token = result['token'];
                              UserData.firstName = result['data']['firstName'];
                              UserData.lastName = result['data']['lastName'];
                              UserData.email = result['data']['email'];
                              UserData.phone = result['data']['mobile'];

                              sharedPrefs.setString('email', result['data']['email']);
                              sharedPrefs.setString('firstName', result['data']['firstName']);
                              sharedPrefs.setString('phone', result['data']['mobile']);
                              sharedPrefs.setString('lastName', result['data']['lastName']);
                              sharedPrefs.setString('token', result['token']);

                              Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(builder: (context) =>
                              const MainBottomNavBar()), (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Email/Password is worng. Try again.'),),);
                            }
                          }
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
                                        builder: (
                                            context) => const RegisterScreen()));
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
        ),
      ),
    );
  }
}
