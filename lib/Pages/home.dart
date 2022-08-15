// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Models/cardListModel.dart';
import 'package:sharedspace/Services/service.dart';
import 'package:sharedspace/Widgets/IconButton.dart';
import 'package:sharedspace/widgets/cardList.dart';

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
              header(context),
              myProfile(),
              SizedBox(
                height: 25,
              ),
              mySpaces(),
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
          Get.toNamed('/settings'),
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
              style: ThemeService().headingStyle,
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
              style: ThemeService().headingStyle,
            ),
            IconButtonCustom(
              color: primaryClr,
              icon: add,
              size: 30,
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
