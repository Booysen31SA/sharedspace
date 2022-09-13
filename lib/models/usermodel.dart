import 'package:intl/intl.dart';

class UserModel {
  final String uid;
  final String? firstname;
  final String? surname;
  final String? email;
  final DateTime? dateCreated;
  final String? color;
  final String? groupid;

  UserModel({
    required this.uid,
    this.firstname,
    this.surname,
    this.email,
    this.dateCreated,
    this.color,
    this.groupid,
  });

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      firstname: data['firstname'],
      surname: data['surname'],
      email: data['email'],
      dateCreated:
          DateFormat('yyyy-MM-dd').parse(data['dateCreated'].toString()),
      color: data['color'],
      groupid: data['groupid'],
    );
  }

  factory UserModel.fromDS(String id, Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      firstname: data['firstname'],
      surname: data['surname'],
      email: data['email'],
      dateCreated:
          DateFormat('yyyy-MM-dd').parse(data['dateCreated'].toString()),
      color: data['color'],
      groupid: data['groupid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "surname": surname,
      "firstname": firstname,
      "email": email,
      "dateCreated": DateFormat('yyyy-MM-dd').parse(dateCreated.toString()),
      "uid": uid,
      "color": color,
      "groupid": groupid,
    };
  }
}
