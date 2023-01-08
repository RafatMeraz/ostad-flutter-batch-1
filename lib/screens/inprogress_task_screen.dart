import 'package:flutter/material.dart';

import '../widgets/task_widget.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({Key? key}) : super(key: key);

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return TaskWidget(
            title: 'Title',
            description: 'dsfsd',
            date: '30 Jan 2023',
            onDeleteTap: () {},
            onEditTap: () {},
            type: 'In Progress',
          );
        },
    );
  }
}
