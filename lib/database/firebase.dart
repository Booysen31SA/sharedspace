// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharedspace/view/loadingView.dart';

class FlutterFireAuthService {
  final FirebaseAuth _firebaseAuth;

  FlutterFireAuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut({required BuildContext context}) async {
    await _firebaseAuth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  Future<String> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Signed in');

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
      required BuildContext context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('Signed in');

      Navigator.pushReplacementNamed(context, '/');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message.toString();
    }
  }
}
