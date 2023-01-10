import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/widgets/background_image.dart';
import 'package:ostad_flutter_batch_one/widgets/reusable_app_bar.dart';
import 'package:ostad_flutter_batch_one/widgets/reusable_elevated_button.dart';
import 'package:ostad_flutter_batch_one/widgets/text_styles.dart';

import '../widgets/decorations_styles.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildReusableAppBar(context, isTappable: false),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add New Task', style: pageTitleTextStyle),
                const SizedBox(height: 16),
                TextField(
                  decoration: textFieldInputDecoration('Subject'),
                ),
                const SizedBox(height: 8),
                TextField(
                  maxLines: 10,
                  decoration: textFieldInputDecoration('Description'),
                ),
                const SizedBox(height: 16),
                ReusableElevatedButton(onTap: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
