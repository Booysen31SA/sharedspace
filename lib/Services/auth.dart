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

  //Sign in with email and password,

  // Sign in with google

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
