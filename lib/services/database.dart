import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharedspace/models/task.dart';

class DatabaseService {
  // Collection References
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('task');

  Future createTask(Task? task) async {
    return await taskCollection
        .doc()
        .set({
          "title": task!.title,
          "note": task.note,
          "isCompleted": false,
          "date": task.date,
          "startTime": task.startTime,
          "endTime": task.endTime,
          "color": task.color,
          "remind": task.remind,
          "repeat": task.repeat,
          "userid": task.userid
        })
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }
}
