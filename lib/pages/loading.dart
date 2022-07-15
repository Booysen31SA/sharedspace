// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sharedspace/configs/theme.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> getLoginDetails() async {
    await Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
