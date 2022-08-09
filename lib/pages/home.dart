// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/models/cardListModel.dart';
import 'package:sharedspace/pages/settings.dart';
import 'package:sharedspace/widgets/cardList.dart';
import 'package:sharedspace/widgets/plusButton.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              // Heading bar
              header(context),
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

header(context) {
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
      GestureDetector(
        child: Icon(Icons.settings),
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Settings(),
            ),
          )
        },
      ),
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
        cardListModel: CardListModel(
          userid: '1',
          imageUrl: 'images/profileImg.png',
          firstName: 'Chandé',
          surname: 'Herman',
          spaceColor: primaryClr,
        ),
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
            PlusButton(
              spaceColor: primaryClr,
              icon: Icons.add,
            ),
          ],
        ),
      ),

      // cards shared spaces
      CardList(
        cardListModel: CardListModel(
          userid: '2',
          imageUrl: 'images/profileImg.png',
          firstName: 'Chandé',
          surname: 'Herman',
          spaceColor: Colors.green,
        ),
      ),

      CardList(
        cardListModel: CardListModel(
          userid: '3',
          imageUrl: 'images/profileImg.png',
          firstName: 'Chandé',
          surname: 'Herman',
          spaceColor: Colors.amber,
        ),
      )
    ],
  );
}
