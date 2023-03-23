import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class IncDecFormField extends StatefulWidget {
  const IncDecFormField({
    Key? key, required this.onChange,
  }) : super(key: key);

  final Function(int, int) onChange;

  @override
  State<IncDecFormField> createState() => _IncDecFormFieldState();
}

class _IncDecFormFieldState extends State<IncDecFormField> {
  int currentValue = 1;
  int previousValue = 1;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = currentValue.toString();
    controller.addListener(() {
      widget.onChange(previousValue, currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (currentValue != previousValue) {
              previousValue = currentValue;
            }
            currentValue++;
            controller.text = currentValue.toString();
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: const Icon(
              Icons.add,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            readOnly: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        GestureDetector(
          onTap: () {
            if (currentValue != previousValue) {
              previousValue = currentValue;
            }
            if (currentValue > 1) {
              currentValue--;
              controller.text = currentValue.toString();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: const Icon(
              Icons.remove,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
