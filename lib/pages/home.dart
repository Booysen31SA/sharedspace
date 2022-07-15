// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/widgets/cardList.dart';
import 'package:sharedspace/widgets/plusButton.dart';

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
              myProfile(),
              SizedBox(
                height: 25,
              ),
              //card for linked profiles
              mySpaces()
            ],
          ),
        ),
      ),
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
            Text(
              "Space",
              style: TextStyle(
                fontSize: 26,
                color: primaryClr,
              ),
            ),
          ],
        ),
      ),
      SizedBox(),
      Icon(Icons.settings),
    ],
  );
}

myProfile() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
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
        name: 'Chandé Herman',
        cardColor: primaryClr,
      ),
    ],
  );
}

mySpaces() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SPACES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            PlusButton(),
          ],
        ),
      ),

      // cards shared spaces
      CardList(
          imageUrl: 'images/profileImg.png',
          name: 'Chandé Herman',
          cardColor: Colors.green),

      CardList(
        imageUrl: 'images/profileImg.png',
        name: 'Chandé Herman',
        cardColor: Colors.amber,
      )
    ],
  );
}
