import 'package:flutter/material.dart';

import '../widgets/task_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: buildSummaryCard(12, 'New')),
            Expanded(child: buildSummaryCard(45, 'Completed')),
            Expanded(child: buildSummaryCard(2, 'Cancelled')),
            Expanded(child: buildSummaryCard(67, 'In progress')),
          ],
        ),
        const SizedBox(height: 16),
        TaskWidget(
          title: 'Title',
          description: 'dsfsd',
          date: '30 Jan 2023',
          onDeleteTap: () {},
          onEditTap: () {},
          type: 'New',
        ),
        TaskWidget(
          title: 'Title',
          description: 'dsfsd',
          date: '30 Jan 2023',
          onDeleteTap: () {},
          onEditTap: () {},
          type: 'New',
        ),
        TaskWidget(
          title: 'Title',
          description: 'dsfsd',
          date: '30 Jan 2023',
          onDeleteTap: () {},
          onEditTap: () {},
          type: 'New',
        ),
      ],
    );
  }

  Card buildSummaryCard(int counter, String title) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Text(
              counter.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            FittedBox(
                child: Text(
              '$title Tasks',
              maxLines: 1,
            ))
          ],
        ),
      ),
    );
  }
}