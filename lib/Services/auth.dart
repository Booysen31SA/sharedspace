import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharedspace/Models/userModel.dart';

class AuthService {
  // create user Object
  UserModel? _userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
// auth stream
  Stream<UserModel?> get userStream {
    return _auth.authStateChanges().map(
          (User? user) => (user == null) ? null : _userFromFirebase(user),
        );
  }

  inputData() {
    final User? user = _auth.currentUser;
    return _userFromFirebase(user);
    // here you write the codes to input the data into firestore
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      email, password, firstname, surname) async {
    try {
      await _auth.createUserWithEmailAndPassword(
              email: email, password: password)
          //.timeout(const Duration(seconds: 10))
          ;

      //return authResult;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Sign in with email and password,
  Future emailAndPasswordSignIn(email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      var errorCode = e.code;
      var errorMessage = e.message;
      print(errorMessage);
      if (errorCode == 'auth/wrong-password') {
        return ('Wrong Password.');
      } else {
        return errorMessage;
      }
    }
  }

  // Sign in with google
  Future googleSignIn() async {
    print('Google Sign in');
  }

  // is Email used?
  Future isEmailChecked(email) async {
    //call database().user().where
    print('Checking if user exist');
  }

  //Sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      return 'Signed Out';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
