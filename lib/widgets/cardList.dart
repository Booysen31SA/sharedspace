// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sharedspace/models/cardListModel.dart';
import 'package:sharedspace/pages/space.dart';

class CardList extends StatelessWidget {
  final CardListModel cardListModel;
  const CardList({
    Key? key,
    required this.cardListModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Space(
              cardListModel: cardListModel,
            ),
          ),
        )
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 15,
        ),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardListModel.spaceColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(cardListModel.imageUrl),
                  maxRadius: 28,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cardListModel.firstName} ${cardListModel.surname}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 40,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
