import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sharedspace/configs/themes.dart';

class DataLoading extends StatelessWidget {
  const DataLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Displaying LoadingSpinner to indicate waiting state
        //     const Center(
        //   child: CircularProgressIndicator(),
        // );

        const SpinKitRotatingCircle(
      color: primaryClr,
      size: 80,
    );
  }
}
