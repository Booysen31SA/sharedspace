// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/models/cardListModel.dart';
import 'package:sharedspace/widgets/TableCalendarView.dart';
import 'package:sharedspace/widgets/plusButton.dart';

class Space extends StatefulWidget {
  final CardListModel cardListModel;
  const Space({
    Key? key,
    required this.cardListModel,
  }) : super(key: key);

  @override
  State<Space> createState() => _SpaceState();
}

class _SpaceState extends State<Space> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              // header
              header(
                context,
                widget.cardListModel,
              ),
              TableCalendarView()
            ],
          ),
        ),
      ),
    );
  }

  header(context, cardListModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.pop(context),
          },
          child: Row(
            children: [
              Icon(
                backArrow,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '${cardListModel.firstName} ${cardListModel.surname}',
                style: TextStyle(
                  fontSize: 26,
                  color: primaryClr,
                ),
              ),
            ],
          ),
        ),
        PlusButton(spaceColor: primaryClr),
      ],
    );
  }
}
