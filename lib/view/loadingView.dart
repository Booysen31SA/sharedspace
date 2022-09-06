import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
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

class _LoadingViewState extends State<LoadingView>
    with TickerProviderStateMixin {
  late FlutterGifController controller;

  @override
  void initState() {
    controller = FlutterGifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.repeat(
        min: 0,
        max: 20,
        period: const Duration(seconds: 2),
      );
    });
    super.initState();
  }

  @override
  dispose() {
    controller.dispose(); // you need this
    super.dispose();
  }

  getRedirectRoute(firebaseUser) {
    Future.delayed(const Duration(seconds: 3), () async {
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
    return Scaffold(
      backgroundColor: primaryClr,
      body: Center(
          child: GifImage(
        controller: controller,
        image: const AssetImage('images/loading_gifs/loading_gif_1.gif'),
      )
          // SpinKitRotatingCircle(
          //   color: Colors.white,
          //   size: 80,
          // ),
          ),
    );
  }
}
