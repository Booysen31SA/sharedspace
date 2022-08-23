import 'package:intl/intl.dart';

class UserModel {
  final String uid;
  final String? firstname;
  final String? surname;
  final String? email;
  final DateTime? dateCreated;
  final DateTime? lastSignInTime;

  UserModel(
      {required this.uid,
      this.firstname,
      this.surname,
      this.email,
      this.dateCreated,
      this.lastSignInTime});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      firstname: data['firstname'],
      surname: data['surname'],
      email: data['email'],
      dateCreated:
          DateFormat('yyyy-MM-dd').parse(data['dateCreated'].toString()),
      lastSignInTime:
          DateFormat('yyyy-MM-dd').parse(data['lastSignInTime'].toString()),
    );
  }

  factory UserModel.fromDS(String id, Map<String, dynamic> data) {
    return UserModel(
      uid: id,
      firstname: data['firstname'],
      surname: data['surname'],
      email: data['email'],
      dateCreated:
          DateFormat('yyyy-MM-dd').parse(data['dateCreated'].toString()),
      lastSignInTime:
          DateFormat('yyyy-MM-dd').parse(data['lastSignInTime'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "surname": surname,
      "firstname": firstname,
      "email": email,
      "dateCreated":
          DateFormat('yyyy-MM-dd').parse(dateCreated.toString()).toString(),
      "lastSignInTime":
          DateFormat('yyyy-MM-dd').parse(lastSignInTime.toString()).toString(),
      "uid": uid,
    };
  }
}
