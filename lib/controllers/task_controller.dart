// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:sharedspace/db/db_helper.dart';
import 'package:sharedspace/models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insertTask(task);
  }
}
