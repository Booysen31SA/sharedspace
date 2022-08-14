import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:intl/intl.dart';

class EventModel {
  final String? userid;
  final String title;
  final String note;
  final DateTime date;

  EventModel({
    this.userid,
    required this.title,
    required this.note,
    required this.date,
  });

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      note: data['note'],
      date: DateFormat('yyyy-MM-dd').parse(data['date'].toString()),
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
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
