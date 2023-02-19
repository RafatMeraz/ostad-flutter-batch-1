import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor)),
      ),
    );
  }
}
