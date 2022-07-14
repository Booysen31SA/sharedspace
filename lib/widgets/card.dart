// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedspace/configs/theme.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryClr,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/profile.png'),
                radius: 25,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Name and Surname',
                style: TextStyle(
                  color: Colors.white,
                ),
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
