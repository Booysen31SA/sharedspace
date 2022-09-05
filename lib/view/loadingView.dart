import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';
import 'package:sharedspace/view/auth/signInView.dart';
import 'package:sharedspace/view/homeView.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  getRedirectRoute(firebaseUser) {
    Future.delayed(const Duration(seconds: 0), () async {
      if (firebaseUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/signin');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    getRedirectRoute(firebaseUser);
    // loading
    return const Scaffold(
      backgroundColor: primaryClr,
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }
}
