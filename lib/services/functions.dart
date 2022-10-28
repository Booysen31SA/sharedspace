// ignore_for_file: invalid_return_type_for_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/models/noteModel.dart';
import 'package:sharedspace/models/sharedspacegroup.dart';
import 'package:sharedspace/models/sharedspacegroup_user.dart';
import 'package:sharedspace/models/usermodel.dart';
import '../database/firebase_helpers.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var uuid = const Uuid();

Stream<QuerySnapshot> getUserDetails(firebaseUser) {
  List<UserModel> groupList = [];

  return FirebaseFirestore.instance
      .collection('User')
      .where('uid', isEqualTo: firebaseUser!.uid)
      .snapshots();
}

Stream<QuerySnapshot> getSpaceGroups(firebaseUser) {
  return FirebaseFirestore.instance
      .collection('SharedSpaceGroup_User')
      .where('user_uid', isEqualTo: firebaseUser!.uid)
      .snapshots();
}

Stream getGroupDetails(groupid) {
  return FirebaseFirestore.instance
      .collection('SharedSpaceGroup')
      .where('groupid', isEqualTo: groupid)
      .snapshots();
}

Stream<QuerySnapshot> getGroupNotes(groupid) {
  return FirebaseFirestore.instance
      .collection('Notes')
      .where('groupid', isEqualTo: groupid)
      .orderBy('timecreated', descending: true)
      .snapshots();
}

Stream<QuerySnapshot> getNote(key) {
  return FirebaseFirestore.instance
      .collection('Notes')
      .where('key', isEqualTo: key)
      .snapshots();
}

getUserDetailsFuture(firebaseUser) async {
  List<UserModel> groupList = [];
  var data = await userDBS
      .getQueryList(args: [QueryArgsV2('uid', isEqualTo: firebaseUser!.uid)])
      .then((value) => {groupList = value.toList()})
      .catchError((error) => {print(error)});
  return groupList;
}

getSharedSpaceDetailsByGroupId(String? groupid) async {
  List<SharedSpaceGroup> sharedSpaceList = [];
  await sharedSpaceDBS.getQueryList(
    args: [QueryArgsV2('groupid', isEqualTo: groupid)],
  ).then((value) {
    if (value.isNotEmpty) {
      sharedSpaceList.add(value.first);
    }
  }).catchError(
    (error) => {
      print('Error'),
      print(error),
    },
  );

  return sharedSpaceList[0];
}

createNote(
    {context,
    key,
    groupid,
    usercreated,
    title,
    description,
    isEditable}) async {
  var keyUuid = uuid.v1();
  var isImportant = false;

  try {
    var userDetails = await getUserDetailsFuture(usercreated);

    NoteModel note = NoteModel(
      key: keyUuid,
      groupid: groupid,
      usercreated: '${userDetails[0].firstname} ${userDetails[0].surname}',
      title: title,
      description: description.toString(),
      timecreated: DateFormat('yyy-MM-dd hh:mm:ss')
          .parse(DateTime.now().toString())
          .toString(),
      important: isImportant,
      isEditable: isEditable == 'Yes' ? true : false,
    );

    var result = await noteDBS.create(note.toMap());

    if (result.id.length > 0) {
      Navigator.pop(context);
    }
    return true;
  } catch (error) {
    print(error);
    return false;
  }
  //timecreated
}

updateNote(
    {context,
    id,
    key,
    groupid,
    usercreated,
    title,
    description,
    timecreated,
    isEditable}) async {
  try {
    //var userDetails = await getUserDetailsFuture(usercreated);

    NoteModel note = NoteModel(
      key: key,
      groupid: groupid,
      usercreated: usercreated,
      title: title,
      description: description.toString(),
      timecreated: timecreated,
      isEditable: isEditable,
    );

    var result = await noteDBS.updateData(id, note.toMap());
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}

createSharedSpaceGroup({context, groupname, groupcolor, useruid}) async {
  var groupuuid = uuid.v1();
  try {
    SharedSpaceGroup sharedGroup = SharedSpaceGroup(
      groupid: groupuuid,
      groupname: groupname,
      groupcolor: groupcolor.toString(),
      useruid: useruid,
      datecreated:
          DateFormat('yyy-MM-dd').parse(DateTime.now().toString()).toString(),
    );

    await sharedSpaceDBS.create(sharedGroup.toMap());

    var result =
        await createSharedSpaceLink(groupuuid: groupuuid, useruid: useruid);

    if (result) {
      Navigator.pop(context);
    }
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}

createSharedSpaceLink({groupuuid, useruid}) async {
  try {
    sharedSpaceGroup_User groupUser = sharedSpaceGroup_User(
      groupid: groupuuid,
      user_uid: useruid,
      key: uuid.v4(),
    );

    await sharedSpaceGroupUser.create(groupUser.toMap());
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}

updateGroupSetting({id, data}) async {
  try {
    SharedSpaceGroup sharedGroup = SharedSpaceGroup(
      groupid: data.groupid,
      groupname: data.groupname,
      groupcolor: data.groupcolor.toString(),
      useruid: data.useruid,
      datecreated: data.datecreated.toString(),
    );

    await sharedSpaceDBS.updateData(id, data.toMap());
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

updateProfileSetting({id, data}) async {
  try {
    UserModel userModel = UserModel(
      uid: data.uid,
      firstname: data.firstname,
      surname: data.surname,
      dateCreated: data.dateCreated,
      color: data.color.toString(),
      groupid: data.groupid,
      email: data.email,
    );

    await userDBS.updateData(
      id,
      data.toMap(),
    );
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}
