import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/models/new_task_model.dart';
import 'package:ostad_flutter_batch_one/network_services/network_requester.dart';
import 'package:ostad_flutter_batch_one/network_services/urls.dart';

import '../widgets/task_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  NewTaskModel? _newTaskModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getNewTaskFromApi();
    });
  }

  Future<void> getNewTaskFromApi() async {
    final response = await NetworkRequester().getRequest(Urls.newTask);
    if (response['status'] == 'success') {
      _newTaskModel = NewTaskModel.fromJson(response);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.green,
          child: Row(
            children: [
              Expanded(child: buildSummaryCard(12, 'New')),
              Expanded(child: buildSummaryCard(45, 'Completed')),
              Expanded(child: buildSummaryCard(2, 'Cancelled')),
              Expanded(child: buildSummaryCard(67, 'In progress')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (_newTaskModel == null)
          const Expanded(child: Center(child: CircularProgressIndicator()))
        else
          Expanded(child: ListView.builder(
            itemCount: _newTaskModel?.tasks?.length ?? 0,
            itemBuilder: (context, index) {
              final task = _newTaskModel!.tasks![index];
              return TaskWidget(
                title: task.title ?? 'Unknown',
                description: task.description ?? 'UnKnown',
                date: task.createdDate ?? 'Unknown',
                onDeleteTap: () {},
                onEditTap: () {},
                type: task.status ?? 'New',
              );
            },
          ))
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