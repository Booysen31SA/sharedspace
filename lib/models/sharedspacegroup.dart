import 'package:intl/intl.dart';

class SharedSpaceGroup {
  final String? groupid;
  final String? groupname;
  final String? groupcolor;
  final String? useruid;
  final DateTime? datecreated;

  SharedSpaceGroup({
    this.groupid,
    this.groupname,
    this.groupcolor,
    this.useruid,
    this.datecreated,
  });

  factory SharedSpaceGroup.fromMap(Map data) {
    return SharedSpaceGroup(
      groupid: data['Groupid'],
      groupname: data['GroupName'],
      groupcolor: data['GroupColor'],
      useruid: data['User_uid'],
      datecreated:
          DateFormat('yyyy-MM-dd').parse(data['date_created'].toString()),
    );
  }

  factory SharedSpaceGroup.fromDS(String id, Map<String, dynamic> data) {
    return SharedSpaceGroup(
      groupid: data['Groupid'],
      groupname: data['GroupName'],
      groupcolor: data['GroupColor'],
      useruid: data['User_uid'],
      datecreated:
          DateFormat('yyyy-MM-dd').parse(data['date_created'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Groupid": groupid,
      "GroupName": groupname,
      "GroupColor": groupcolor,
      "date_created": DateFormat('yyyy-MM-dd').parse(datecreated.toString()),
      "User_uid": useruid,
    };
  }
}
