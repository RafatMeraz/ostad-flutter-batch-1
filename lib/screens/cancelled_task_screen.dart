import 'package:flutter/material.dart';

import '../widgets/task_widget.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({Key? key}) : super(key: key);

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
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
          type: 'Cancelled',
        );
      },
    );
  }
}
