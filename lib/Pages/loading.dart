import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Models/userModel.dart';
import 'package:sharedspace/Pages/home.dart';

import 'Auth/signin.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> getLoginDetails() async {
    print('function');
    Future.delayed(const Duration(seconds: 0), () async {
      final userData = await Provider.of<UserModel?>(context, listen: false);
      print(userData == null);
      if (userData == null) {
        Navigator.pushReplacementNamed(context, '/signin');
        //return SignIn();
      } else {
        print('Home');
        Navigator.pushReplacementNamed(context, '/home');
        //return Home();
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
    //Timer(const Duration(seconds: 5), () => {});

    final userData = Provider.of<UserModel?>(context, listen: true);
    //getLoginDetails();
    return (userData != null) ? Home() : SignIn();
    // return const Scaffold(
    //   backgroundColor: primaryClr,
    //   body: Center(
    //     child: SpinKitRotatingCircle(
    //       color: Colors.white,
    //       size: 80,
    //     ),
    //   ),
    // );
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
