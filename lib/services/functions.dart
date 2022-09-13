// ignore_for_file: invalid_return_type_for_catch_error

import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:sharedspace/models/sharedspacegroup.dart';
import 'package:sharedspace/models/sharedspacegroup_user.dart';
import 'package:sharedspace/models/usermodel.dart';
import '../database/firebase_helpers.dart';

getUserDetails(firebaseUser) async {
  List<UserModel> groupList = [];
  var data = await userDBS
      .getQueryList(args: [QueryArgsV2('uid', isEqualTo: firebaseUser!.uid)])
      .then((value) => {groupList = value.toList()})
      .catchError((error) => {print(error)});
  return groupList;
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
    await sharedSpaceDBS.getQueryList(
      args: [QueryArgsV2('Groupid', isEqualTo: groupList[i].groupid)],
    ).then((value) {
      if (value.isNotEmpty) {
        sharedSpaceList.add(value.first);
      }
    }).catchError(
      (error) => {
        print(error),
      },
    );
  }
  return sharedSpaceList;
}
