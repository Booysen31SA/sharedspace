class sharedSpaceGroup_User {
  final String? key;
  final String? groupid;
  final String? user_uid;

  sharedSpaceGroup_User({
    this.key,
    this.groupid,
    this.user_uid,
  });

  factory sharedSpaceGroup_User.fromMap(Map data) {
    return sharedSpaceGroup_User(
      key: data['key'],
      groupid: data['groupid'],
      user_uid: data['user_uid'],
    );
  }

  factory sharedSpaceGroup_User.fromDS(String id, Map<String, dynamic> data) {
    return sharedSpaceGroup_User(
      key: data['key'],
      groupid: data['groupid'],
      user_uid: data['user_uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "key": key,
      "groupid": groupid,
      "user_uid": user_uid,
    };
  }
}
