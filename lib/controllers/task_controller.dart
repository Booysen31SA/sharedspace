// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
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

  List<Task> getEventsFromDay(DateTime date) {
    Map<DateTime, List<Task>> selectedEvents = {};
    List<Task> t = [
      Task(
        id: 1,
        date: DateTime.now().toString(),
        color: 1,
        endTime: null,
        isCompleted: 0,
        note: 'Testing',
        remind: 15,
        repeat: 'Daily',
        startTime: null,
        title: 'This is a title',
        userid: '1',
      ),
      Task(
        id: 1,
        date: DateTime.now().toString(),
        color: 1,
        endTime: null,
        isCompleted: 0,
        note: 'Testing',
        remind: 15,
        repeat: 'Daily',
        startTime: null,
        title: 'This is a title',
        userid: '1',
      )
    ];

    selectedEvents[DateTime(2022, 7, 29)] = List.from(t);
    return selectedEvents[DateTime(date.year, date.month, date.day)] ?? [];
  }
}
