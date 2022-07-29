// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:sharedspace/models/task.dart';
import 'package:sharedspace/services/database.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future addTask({Task? task}) async {
    var result = await DatabaseService().createTask(task);
    return result;
  }
}
