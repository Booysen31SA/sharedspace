import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:sharedspace/models/task.dart';

DatabaseService<TaskModel> taskDBS = DatabaseService<TaskModel>("task",
    fromDS: (id, data) => TaskModel.fromDS(id, data!),
    toMap: (event) => event.toMap());
