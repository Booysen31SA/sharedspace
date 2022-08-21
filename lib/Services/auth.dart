import 'package:firebase_auth/firebase_auth.dart';
import 'package:sharedspace/Models/userModel.dart';

class AuthService {
  // create user Object
  UserModel? _userFromFirebase(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

// auth stream
  Stream<UserModel?> get userStream {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // register with email and password
  Future registerWithEmailAndPassword(email, password) async {
    print('Register With Email and password');
  }

  //Sign in with email and password,
  Future emailAndPasswordSignIn(email, password) async {
    print('Email and Password Sign in');
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
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
