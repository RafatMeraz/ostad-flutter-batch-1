import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title, [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: isError ? Colors.red : null,
    ),
  );
}
