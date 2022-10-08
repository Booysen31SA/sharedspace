import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:sharedspace/models/note.dart';
import 'package:sharedspace/models/sharedspacegroup.dart';
import 'package:sharedspace/models/sharedspacegroup_user.dart';
import 'package:sharedspace/models/usermodel.dart';

DatabaseService<UserModel> userDBS = DatabaseService(
  'User',
  fromDS: (uid, data) => UserModel.fromDS(uid, data!),
  toMap: (user) => user.toMap(),
);

DatabaseService<sharedSpaceGroup_User> sharedSpaceGroupUser = DatabaseService(
  'SharedSpaceGroup_User',
  fromDS: (key, data) => sharedSpaceGroup_User.fromDS(key, data!),
  toMap: (sharedSpaceGroup_User) => sharedSpaceGroup_User.toMap(),
);

DatabaseService<SharedSpaceGroup> sharedSpaceDBS = DatabaseService(
  'SharedSpaceGroup',
  fromDS: (groupid, data) => SharedSpaceGroup.fromDS(groupid, data!),
  toMap: (sharedSpaceGroup) => sharedSpaceGroup.toMap(),
);

DatabaseService<Note> noteDBS = DatabaseService(
  'Notes',
  fromDS: (key, data) => Note.fromDS(key, data!),
  toMap: (note) => note.toMap(),
);
