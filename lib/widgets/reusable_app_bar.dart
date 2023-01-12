import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/screens/login.dart';
import 'package:ostad_flutter_batch_one/screens/profile_update_screen.dart';
import 'package:ostad_flutter_batch_one/utils/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar buildReusableAppBar(context, {bool isTappable = true}) {
  return AppBar(
    backgroundColor: Colors.green,
    title: ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        if (isTappable == false) {
          return;
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade800,
        child: const Icon(Icons.person),
      ),
      title: Text('${UserData.firstName ?? ''} ${UserData.lastName ?? ''}'),
      subtitle: Text(UserData.email ?? ''),
    ),
    actions: [
      IconButton(
          onPressed: () async {
            final sharedPrefs = await SharedPreferences.getInstance();
            sharedPrefs.clear();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
          },
          icon: const Icon(Icons.logout))
    ],
  );
}
