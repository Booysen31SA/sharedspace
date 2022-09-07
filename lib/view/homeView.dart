import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // use new Color(matchDetail['colorString']),

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(firebaseUser!.uid.toString()),
            Center(
              child: MaterialButton(
                onPressed: () {
                  var result = context
                      .read<FlutterFireAuthService>()
                      .signOut(context: context);
                },
                child: const Text(
                  'LogOut',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
