// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, avoid_unnecessary_containers

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/pages/Forms/AddTask.dart';
import 'package:sharedspace/services/themeService.dart';
import 'package:sharedspace/widgets/button.dart';
import 'package:sharedspace/widgets/plusButton.dart';

class Space extends StatefulWidget {
  final String name;
  final Color spaceColor;
  const Space({Key? key, required this.name, required this.spaceColor})
      : super(key: key);

  @override
  State<Space> createState() => _SpaceState();
}

class _SpaceState extends State<Space> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              // header
              header(context, widget.name, widget.spaceColor),
              //

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                      left: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateFormat.yMMMMd().format(_selectedDate),
                            style: subHeadingStyle),
                      ],
                    ),
                  ),
                ],
              ),

              // dates row
              addDateBar(widget.spaceColor),
              addTaskBar(widget.spaceColor),
              //todays tasks

              //appBar
              // utill function
            ],
          ),
        ),
      ),
    );
  }

  header(context, name, spaceColor) {
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
                '$name',
                style: TextStyle(
                  fontSize: 26,
                  color: spaceColor,
                ),
              ),
            ],
          ),
        ),
        PlusButton(spaceColor: spaceColor),
      ],
    );
  }

  addDateBar(spaceColor) {
    return DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: spaceColor,
      selectedTextColor: Colors.white,
      dateTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      dayTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      monthTextStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      onDateChange: (date) {
        print(date);
        _selectedDate = date;
      },
    );
  }

  addTaskBar(spaceColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Tasks',
            style: subHeadingStyle,
          ),
          MyButton(
            label: "+ Add Task",
            spaceColor: spaceColor,
            onTap: () => {
              Get.to(
                AddTask(
                  name: 'ADD TASK',
                  cardColor: spaceColor,
                ),
              )
            },
          )
        ],
      ),
    );
  }
}
