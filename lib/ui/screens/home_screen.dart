import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/images/logo_nav.svg'
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Icon(
              Icons.person,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 5,),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Icon(
              Icons.call,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 5,),
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              radius: 16,
              child: Icon(
                Icons.notifications,
                size: 18,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(width: 8,),
        ],
      ),
    );
  }
}
