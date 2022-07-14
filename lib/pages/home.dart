// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/widgets/cardList.dart';

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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        bottom: 15,
                      ),
                      child: Text(
                        'MY PROFILE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                CardList(
                  imageUrl: 'images/profileImg.png',
                  name: 'Chandé',
                  surname: 'Herman',
                  userList: null,
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
