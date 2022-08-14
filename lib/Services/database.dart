import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:sharedspace/Models/eventModel.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>(
  "Event",
  fromDS: (id, data) => EventModel.fromDS(id, data!),
  toMap: (event) => event.toMap(),
);
