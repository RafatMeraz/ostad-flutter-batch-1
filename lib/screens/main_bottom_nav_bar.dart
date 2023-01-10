import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/screens/add_new_task_screen.dart';
import 'package:ostad_flutter_batch_one/screens/cancelled_task_screen.dart';
import 'package:ostad_flutter_batch_one/screens/completed_task_screen.dart';
import 'package:ostad_flutter_batch_one/screens/inprogress_task_screen.dart';
import 'package:ostad_flutter_batch_one/screens/new_task_screen.dart';

import '../widgets/reusable_app_bar.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int currentSelectedScreen = 0;

  final List<Widget> screens = const [
    NewTaskScreen(),
    ComplettedTaskScreen(),
    CancelledTaskScreen(),
    InProgressTaskScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildReusableAppBar(context),
      floatingActionButton: currentSelectedScreen == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            )
          : const SizedBox(),
      body: screens[currentSelectedScreen],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.green,
        currentIndex: currentSelectedScreen,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 8,
        onTap: (index) {
          currentSelectedScreen = index;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.new_label_outlined),
              label: 'New',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_schedule_send_outlined),
              label: 'Cancelled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.refresh), label: 'In Progress'),
        ],
      ),
    );
  }
}
