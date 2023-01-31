import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ostad_flutter_batch_one/network_services/network_requester.dart';
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
  final _form = GlobalKey<FormState>();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 44),
                  const Text('Join Us', style: pageTitleTextStyle),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailTEController,
                    decoration: textFieldInputDecoration('Email'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: textFieldInputDecoration('First name'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: textFieldInputDecoration('Last name'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _mobileTEController,
                    decoration: textFieldInputDecoration('Mobile'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your mobile';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordTEController,
                    decoration: textFieldInputDecoration('Password'),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ReusableElevatedButton(onTap: () async {
                    if (_form.currentState!.validate()) {
                      final result = await NetworkRequester().postRequest(
                          'https://task.teamrabbil.com/api/v1/registration', {
                        "email": _emailTEController.text,
                        "firstName": _firstNameTEController.text,
                        "lastName": _lastNameTEController.text,
                        "mobile": _mobileTEController.text,
                        "password": _passwordTEController.text,
                        "photo": ""
                      });
                      print(result);
                      if (result['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registration successful')));
                        _emailTEController.text = '';
                        _passwordTEController.text = '';
                        _mobileTEController.text = '';
                        _firstNameTEController.text = '';
                        _lastNameTEController.text = '';
                      }
                    }
                  }),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have Account?'),
                      TextButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Get.back();
                          },
                          child: const Text('Sign In'))
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
