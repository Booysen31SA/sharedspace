import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Models/userModel.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> getLoginDetails(user) async {
    await Future.delayed(const Duration(seconds: 0), () {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/signin');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //getLoginDetails();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Future<UserModel>?>(context);
    //Timer(const Duration(seconds: 5), () => {});
    getLoginDetails(userData);
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


// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:sharedspace/Configs/themes.dart';
// import 'package:sharedspace/Models/userModel.dart';

// class Loading extends StatelessWidget {
//   const Loading({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final userData = Provider.of<Future<UserModel>?>(context);

//     //Timer(const Duration(seconds: 5), () => {});
//     getLoginDetails(context, userData);
//     return const Scaffold(
//       backgroundColor: primaryClr,
//       body: Center(
//         child: SpinKitRotatingCircle(
//           color: Colors.white,
//           size: 80,
//         ),
//       ),
//     );
//   }

//   Future<void> getLoginDetails(context, user) async {
//     await Future.delayed(const Duration(seconds: 5), () {
//       if (user != null) {
//         Navigator.pushReplacementNamed(context, '/signin');
//       } else {
//         Navigator.pushReplacementNamed(context, '/home');
//       }
//     });
//   }
// }
