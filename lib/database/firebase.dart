// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase_helpers.dart';
import 'package:sharedspace/models/usermodel.dart';
import 'package:sharedspace/view/loadingView.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;

  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut({required BuildContext context}) async {
    await _firebaseAuth.signOut();
  }

  Future<String> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.pushReplacementNamed(context, '/');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message.toString();
    }
  }

  Future<String> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String firstname,
      required String lastname,
      required BuildContext context}) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel user = UserModel(
        uid: result.user!.uid,
        firstname: firstname.trim(),
        surname: lastname.trim(),
        email: email.trim(),
        dateCreated: DateFormat('yyy-MM-dd')
            .parse(result.user!.metadata.creationTime.toString()),
        color: primaryClr.toString(),
      );

      userDBS.create(user.toMap());

      Navigator.pushReplacementNamed(context, '/');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message.toString();
    }
  }
}
