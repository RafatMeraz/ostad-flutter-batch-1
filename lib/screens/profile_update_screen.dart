import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/utils/user_data.dart';
import 'package:ostad_flutter_batch_one/widgets/reusable_app_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/background_image.dart';
import '../widgets/decorations_styles.dart';
import '../widgets/reusable_elevated_button.dart';
import '../widgets/text_styles.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  XFile? photoFile;

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileNumberTEController =
      TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTEController.text = UserData.email ?? '';
    _firstNameTEController.text = UserData.firstName ?? '';
    _lastNameTEController.text = UserData.lastName ?? '';
    _mobileNumberTEController.text = UserData.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildReusableAppBar(context, isTappable: false),
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
                  const Text('Update Profile', style: pageTitleTextStyle),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final result = await imagePicker.pickImage(
                          source: ImageSource.camera);
                      if (result != null) {
                        photoFile = result;
                        setState(() {});
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(color: Colors.grey),
                            child: const Text(
                              'Photo',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Visibility(
                            visible: photoFile != null,
                            replacement: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Select a photo',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            child: Image.file(
                              File(photoFile?.path ?? ''),
                              width: 25,
                              height: 25,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              photoFile?.name ?? '',
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: true,
                    controller: _emailTEController,
                    decoration: textFieldInputDecoration('Email'),
                    validator: (String? text) {
                      if (text?.isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _firstNameTEController,
                    decoration: textFieldInputDecoration('First name'),
                    validator: (String? text) {
                      if (text?.isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lastNameTEController,
                    decoration: textFieldInputDecoration('Last name'),
                    validator: (String? text) {
                      if (text?.isEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _mobileNumberTEController,
                    readOnly: true,
                    decoration: textFieldInputDecoration('Mobile'),
                    validator: (String? text) {
                      if (text?.isEmpty ?? true) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: textFieldInputDecoration('Password'),
                    validator: (String? text) {
                      if ((text?.isNotEmpty ?? false) &&
                          ((text?.length ?? 0) <= 7)) {
                        return 'Enter your password more than 7 letters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ReusableElevatedButton(
                    text: 'Update',
                    onTap: () {
                      if (_form.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
