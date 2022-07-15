// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedspace/configs/theme.dart';

class CardList extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String surname;
  final Color cardColor;
  const CardList(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.surname,
      required this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                maxRadius: 28,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name $surname',
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
    );
  }
}
