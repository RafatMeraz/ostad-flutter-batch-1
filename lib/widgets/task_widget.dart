import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.type,
    required this.onEditTap,
    required this.onDeleteTap,
    required this.date,
  }) : super(key: key);

  final String title, description, date, type;
  final VoidCallback onEditTap, onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        tileColor: Colors.green.withOpacity(0.2),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            Text(date),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(type),
                  backgroundColor: Colors.green,
                ),
                ButtonBar(
                  children: [
                    IconButton(
                      onPressed: onEditTap,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: onDeleteTap,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
