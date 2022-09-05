import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FlutterFireAuthService{
    final FirebaseAuth _firebaseAuth;

    FlutterFireAuthService(this._firebaseAuth);

    Stream<User> get authStateChanges => => _firebaseAuth.idTokenChanges();

    Future<void> signOut() async {
        await _firebaseAuth.signOut();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoadingView();
            )
        );
    }

    Future<String> signInWithEmailAndPassword({
        String email,
        String password,
        BuildContext context
    }){
        try {

            await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
            print('Signed in');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoadingView();
                )
            );
            return 'Success';

        } on FirebaseAuthException catch (e) {
            print(e.toString());
            return e.message;
    }
    }

    Future<String> signUpWithEmailAndPassword(
        {
            String email,
            String password,
            BuildContext context
        }
    ){
        try {

            await _firebaseAuth.signUpWithEmailAndPassword(email: email, password: password);
            print('Signed in');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoadingView();
                )
            );
            return 'Success';

        } on FirebaseAuthException catch (e) {
            print(e.toString());
            return e.message;
    }
    }
}