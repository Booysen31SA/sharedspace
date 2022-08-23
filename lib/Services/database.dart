import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:sharedspace/Models/eventModel.dart';
import 'package:sharedspace/Models/userModel.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>(
  "Event",
  fromDS: (id, data) => EventModel.fromDS(id, data!),
  toMap: (event) => event.toMap(),
);

DatabaseService<UserModel> userDBS = DatabaseService<UserModel>(
  'User',
  fromDS: (uid, data) => UserModel.fromDS(uid, data!),
  toMap: (user) => user.toMap(),
);
