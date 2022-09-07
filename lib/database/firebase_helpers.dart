import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:sharedspace/models/usermodel.dart';

DatabaseService<UserModel> userDBS = DatabaseService(
  'User',
  fromDS: (uid, data) => UserModel.fromDS(uid, data!),
  toMap: (user) => user.toMap(),
);
