import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/widgets/reusable_app_bar.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildReusableAppBar(context, isTappable: false),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Update Profile', style: pageTitleTextStyle),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.grey
                          ),
                          child: const Text('Photo', style: TextStyle(
                            color: Colors.white
                          ),),
                        )
                      ],
                    ),
                  ),
                ),
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
                ReusableElevatedButton(text: 'Update', onTap: () {}),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
