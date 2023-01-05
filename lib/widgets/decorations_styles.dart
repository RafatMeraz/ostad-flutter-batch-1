import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hintText) => InputDecoration(
    hintText: hintText,
    fillColor: Colors.white,
    filled: true,
    border: const OutlineInputBorder(borderSide: BorderSide.none));
