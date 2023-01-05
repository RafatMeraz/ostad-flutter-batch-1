import 'package:flutter/material.dart';

class ReusableElevatedButton extends StatelessWidget {
  const ReusableElevatedButton({Key? key, required this.onTap, this.text})
      : super(key: key);

  final VoidCallback onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: onTap,
          child: text != null
              ? Text(text ?? '')
              : const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                )),
    );
  }
}
