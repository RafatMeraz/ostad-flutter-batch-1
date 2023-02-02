import 'package:get/get.dart';

import '../models/new_task_model.dart';
import '../network_services/network_requester.dart';
import '../network_services/urls.dart';

class NewTasksController extends GetxController {
  bool _inProgress = false;
  NewTaskModel? _newTaskModel;

  NewTaskModel? get newTaskModel => _newTaskModel;

  bool get inProgress => _inProgress;

  Future<void> getNewTaskFromApi() async {
    _inProgress = true;
    update();
    final response = await NetworkRequester().getRequest(Urls.newTask);
    if (response['status'] == 'success') {
      _newTaskModel = NewTaskModel.fromJson(response);
    }
    _inProgress = false;
    update();
  }
}
