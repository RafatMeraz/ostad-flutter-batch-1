import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ostad_flutter_batch_one/ui/widgets/app_textfield_widget.dart';

import '../widgets/app_elevated_button.dart';
import 'main_bottom_navigation_bar.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 46,
                ),
                SvgPicture.asset(
                  'assets/images/crafty-bay-logo.svg',
                  width: 120,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Completed Profile',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Get started with us with your details',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFa6a6a6),
                      letterSpacing: 0.5),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFieldWidget(
                    controller: TextEditingController(),
                    hintText: 'First name'),
                const SizedBox(
                  height: 8,
                ),
                AppTextFieldWidget(
                    controller: TextEditingController(), hintText: 'Last name'),
                const SizedBox(
                  height: 8,
                ),
                AppTextFieldWidget(
                    controller: TextEditingController(), hintText: 'Mobile'),
                const SizedBox(
                  height: 8,
                ),
                AppTextFieldWidget(
                    controller: TextEditingController(), hintText: 'City'),
                const SizedBox(
                  height: 8,
                ),
                AppTextFieldWidget(
                    maxLines: 4,
                    controller: TextEditingController(),
                    hintText: 'Shipping Address'),
                const SizedBox(
                  height: 16,
                ),
                AppElevatedButton(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MainBottomNavigationBar()),
                        (route) => false);
                  },
                  text: 'Complete',
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
