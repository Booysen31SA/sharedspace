// ignore_for_file: invalid_return_type_for_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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

// first group_user then inside do a stream to group
// Stream getCurrentUserModelStream() {
//   return FirebaseAuth.instance.authStateChanges().asyncExpand(
//     (currentUser) {
//       if (currentUser == null) {
//         return Stream.value(null);
//       }
//       return FirebaseFirestore.instance
//           .collection('users')
//           .doc(currentUser.uid)
//           .snapshots()
//           .map((doc) {
//         final userData = doc.data();
//         if (userData == null) {
//           return null;
//         }
//         return UserModel.fromJson(userData);
//       });
//     },
//   );
// }

Stream<QuerySnapshot> getSpaceGroups(firebaseUser) {
  return FirebaseFirestore.instance
      .collection('SharedSpaceGroup_User')
      .where('User_uid', isEqualTo: firebaseUser!.uid)
      .snapshots();
}

Stream getGroupDetails(groupid) {
  return FirebaseFirestore.instance
      .collection('SharedSpaceGroup')
      .where('groupid', isEqualTo: groupid)
      .snapshots();
}

getUserSpaces(firebaseUser) async {
  try {
    List<sharedSpaceGroup_User> groupList = [];
    List<SharedSpaceGroup> sharedSpaceList = [];

    var groupUser = await sharedSpaceGroupUser
        .getQueryList(
          args: [QueryArgsV2('User_uid', isEqualTo: firebaseUser!.uid)],
        )
        .then((value) => {
              groupList = value.toList(),
            })
        .catchError(
          (error) => {
            print(error),
          },
        );

    sharedSpaceList = await getSharedSpaceDetails(groupList);

    // get sharedSpaceGroup by on data recieced from list above
    return sharedSpaceList;
  } catch (e) {
    print(e.toString());
  }
}

getSharedSpaceDetails(List<sharedSpaceGroup_User> groupList) async {
  List<SharedSpaceGroup> sharedSpaceList = [];

  for (int i = 0; i < groupList.length; i++) {
    sharedSpaceList.add(
      await getSharedSpaceDetailsByGroupId(groupList[i].groupid),
    );
  }
  return sharedSpaceList;
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
      Navigator.pushReplacementNamed(context, '/home');
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
