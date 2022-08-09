import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:intl/intl.dart';

class TaskModel {
  final String? userid;
  final String title;
  final String note;
  final DateTime date;

  TaskModel({
    this.userid,
    required this.title,
    required this.note,
    required this.date,
  });

  factory TaskModel.fromMap(Map data) {
    return TaskModel(
      title: data['title'],
      note: data['note'],
      date: DateFormat('yyyy-MM-dd').parse(data['date'].toString()),
    );
  }

  factory TaskModel.fromDS(String id, Map<String, dynamic> data) {
    return TaskModel(
      userid: id,
      title: data['title'],
      note: data['note'],
      date: DateFormat('yyyy-MM-dd').parse(data['date'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "note": note,
      "date": DateFormat('yyyy-MM-dd').parse(date.toString()).toString(),
      "id": userid,
    };
  }
}
