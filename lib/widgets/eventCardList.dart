// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:sharedspace/configs/theme.dart';

class EventCardList extends StatelessWidget {
  final event;
  const EventCardList({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 15, top: 10),
          child: Row(
            children: [
              Column(
                children: [
                  Text('15:00'),
                  Text('16:00'),
                ],
              ),
              Container(
                color: primaryClr,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 2),
                margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title),
                  Text(event.note),
                ],
              ),
            ],
          ),
        ),
        Container(
          //color: Colors.grey[400],
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          margin: EdgeInsets.only(
            top: 15,
            bottom: 15,
            left: 50,
            right: 50,
          ),
        )
      ],
    );
  }
}
