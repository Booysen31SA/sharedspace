// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedspace/configs/theme.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            // Heading bar
            header(),
            //Card for my profile
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'MY PROFILE',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey.shade600),
                ),
              ],
            )
            //card for linked profiles
          ],
        ),
      )),
    );
  }
}

header() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: primaryClr,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              child: Text(
                "Shared",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text("Space",
                style: TextStyle(
                  fontSize: 26,
                  color: primaryClr,
                )),
          ],
        ),
      ),
      SizedBox(),
      Icon(Icons.settings),
    ],
  );
}
