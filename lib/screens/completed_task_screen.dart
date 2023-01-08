import 'package:flutter/material.dart';

import '../widgets/task_widget.dart';

class ComplettedTaskScreen extends StatefulWidget {
  const ComplettedTaskScreen({Key? key}) : super(key: key);

  @override
  State<ComplettedTaskScreen> createState() => _ComplettedTaskScreenState();
}

class _ComplettedTaskScreenState extends State<ComplettedTaskScreen> {
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
        type: 'Completed',
      );
    });
  }
}
