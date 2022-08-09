// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/models/cardListModel.dart';
import 'package:sharedspace/pages/Forms/addEvent.dart';
import 'package:sharedspace/widgets/TableCalendarView.dart';
import 'package:sharedspace/widgets/plusButton.dart';
import '../globals.dart' as globals;

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
      bottomNavigationBar: BottomAppBar(
        color: primaryClr,
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.calendar_month_outlined),
              iconSize: 30,
              color: Colors.white,
              onPressed: () => {},
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
              icon: Icon(Icons.note_alt_sharp),
              iconSize: 30,
              color: Colors.white,
              onPressed: () => {},
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryClr,
        child: PlusButton(
          spaceColor: primaryClr,
          icon: Icons.add,
        ),
        onPressed: () => {
          Get.to(
            AddEvent(),
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        PlusButton(
          spaceColor: primaryClr,
          icon: Icons.more_vert_rounded,
        ),
      ],
    );
  }
}
