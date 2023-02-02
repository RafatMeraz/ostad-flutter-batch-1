import 'package:flutter/material.dart';
import 'package:ostad_flutter_batch_one/network_services/network_requester.dart';
import 'package:ostad_flutter_batch_one/network_services/urls.dart';
import 'package:ostad_flutter_batch_one/widgets/text_styles.dart';
import 'package:get/get.dart';

import '../state_management/new_tasks_controller.dart';
import '../widgets/reusable_elevated_button.dart';
import '../widgets/task_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final newTasksController = Get.put(NewTasksController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      newTasksController.getNewTaskFromApi();
    });
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
        GetBuilder<NewTasksController>(
            init: NewTasksController(),
            builder: (controller) {
              if (controller.inProgress) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      newTasksController.getNewTaskFromApi();
                    },
                    child: ListView.builder(
                      itemCount: controller.newTaskModel?.tasks?.length ?? 0,
                      itemBuilder: (context, index) {
                        final task = controller.newTaskModel!.tasks![index];
                        return TaskWidget(
                          title: task.title ?? 'Unknown',
                          description: task.description ?? 'UnKnown',
                          date: task.createdDate ?? 'Unknown',
                          onDeleteTap: () {},
                          onEditTap: () {
                            showModalSheetForChangeStatus(task.sId ?? '');
                          },
                          type: task.status ?? 'New',
                        );
                      },
                    ),
                  ),
                );
              }
            }),
      ],
    );
  }

  void showModalSheetForChangeStatus(String taskId) {
    String taskStatus = 'In Progress';

    bool taskStatusChangeInProgress = false;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, changeState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Change status of task',
                      style: pageTitleTextStyle),
                  const SizedBox(height: 24),
                  RadioListTile(
                      title: const Text('In Progress'),
                      value: 'In Progress',
                      onChanged: (value) {
                        taskStatus = value!;
                        changeState(() {});
                      },
                      groupValue: taskStatus),
                  RadioListTile(
                    groupValue: taskStatus,
                    title: const Text('Completed'),
                    value: 'Completed',
                    onChanged: (value) {
                      taskStatus = value!;
                      changeState(() {});
                    },
                  ),
                  RadioListTile(
                    groupValue: taskStatus,
                    title: const Text('Cancelled'),
                    value: 'Cancelled',
                    onChanged: (value) {
                      taskStatus = value!;
                      changeState(() {});
                    },
                  ),
                  const SizedBox(height: 24),
                  if (taskStatusChangeInProgress)
                    const Center(child: CircularProgressIndicator())
                  else
                    ReusableElevatedButton(
                      text: 'Submit',
                      onTap: () async {
                        taskStatusChangeInProgress = true;
                        changeState(() {});
                        final response = await NetworkRequester()
                            .getRequest(Urls.changeStatus(taskId, taskStatus));
                        taskStatusChangeInProgress = false;
                        changeState(() {});
                        if (response['status'] == 'success') {
                          newTasksController.getNewTaskFromApi();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Status change successful!')));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Status change failed! Try again')));
                        }
                      },
                    )
                ],
              ),
            );
          });
        });
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
