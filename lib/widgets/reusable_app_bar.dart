import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/screens/profile_update_screen.dart';

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
      title: const Text('Rabbil Hasan'),
      subtitle: const Text('test@gmail.com'),
    ),
  );
}
