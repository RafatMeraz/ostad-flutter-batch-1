import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/network_services/network_requester.dart';
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
  final TextEditingController subjectTEController = TextEditingController();
  final TextEditingController descriptionTEController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildReusableAppBar(context, isTappable: false),
      body: BackgroundImage(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add New Task', style: pageTitleTextStyle),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: subjectTEController,
                    decoration: textFieldInputDecoration('Subject'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your task subject';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: descriptionTEController,
                    maxLines: 10,
                    decoration: textFieldInputDecoration('Description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter your task descriptions';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  if (inProgress)
                    const Center(child: CircularProgressIndicator())
                  else
                    ReusableElevatedButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        inProgress = true;
                        setState(() {

                        });
                        final response = await NetworkRequester().postRequest(
                          'https://task.teamrabbil.com/api/v1/createTask',
                          {
                            "title": subjectTEController.text.trim(),
                            "description": descriptionTEController.text.trim(),
                            "status": "New"
                          },
                        );
                        inProgress = false;
                        setState(() {

                        });
                        if (response['status'] == 'success') {
                          subjectTEController.clear();
                          descriptionTEController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('New task has been added!')));
                        }
                      }
                    },
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
