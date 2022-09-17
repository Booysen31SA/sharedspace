import 'package:intl/intl.dart';

class SharedSpaceGroup {
  final String? groupid;
  final String? groupname;
  final String? groupcolor;
  final String? useruid;
  final String? datecreated;
  final String? updateid;

  SharedSpaceGroup({
    this.groupid,
    this.groupname,
    this.groupcolor,
    this.useruid,
    this.datecreated,
    this.updateid,
  });

  factory SharedSpaceGroup.fromMap(Map data) {
    return SharedSpaceGroup(
      groupid: data['groupid'],
      groupname: data['groupname'],
      groupcolor: data['groupcolor'],
      useruid: data['user_uid'],
      datecreated: DateFormat('yyyy-MM-dd')
          .parse(data['date_created'].toString())
          .toString(),
    );
  }

  factory SharedSpaceGroup.fromDS(String id, Map<String, dynamic> data) {
    return SharedSpaceGroup(
      updateid: id,
      groupid: data['groupid'],
      groupname: data['groupname'],
      groupcolor: data['groupcolor'],
      useruid: data['user_uid'],
      datecreated: DateFormat('yyyy-MM-dd')
          .parse(data['date_created'].toString())
          .toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "groupid": groupid,
      "groupname": groupname,
      "groupcolor": groupcolor,
      "date_created":
          DateFormat('yyyy-MM-dd').parse(datecreated.toString()).toString(),
      "user_uid": useruid,
    };
  }
}
