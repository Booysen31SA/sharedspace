// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/controllers/task_controller.dart';
import 'package:sharedspace/models/cardListModel.dart';
import 'package:sharedspace/models/task.dart';
import 'package:sharedspace/pages/Forms/AddTask.dart';
import 'package:sharedspace/services/themeService.dart';
import 'package:sharedspace/widgets/button.dart';
import 'package:sharedspace/widgets/plusButton.dart';
import 'package:sharedspace/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

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
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.week;
  final TaskController _taskController = Get.put(TaskController());

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

              Column(
                children: [
                  TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime(2022),
                    lastDay: DateTime(2090),
                    formatAnimationDuration: const Duration(milliseconds: 500),
                    availableCalendarFormats: const {
                      CalendarFormat.month: 'Month',
                      CalendarFormat.week: 'Week',
                    },
                    //formatAnimationCurve: Curves.linear,
                    weekendDays: const [DateTime.saturday, DateTime.sunday],
                    calendarFormat: format,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: true,
                      titleCentered: false,
                      formatButtonShowsNext: false,
                      formatButtonDecoration: BoxDecoration(
                        color: primaryClr,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      formatButtonTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      headerPadding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      selectedDecoration: BoxDecoration(
                        color: primaryClr,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(_selectedDate, date);
                    },
                    onFormatChanged: (CalendarFormat _format) {
                      setState(() {
                        format = _format;
                      });
                    },
                    onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                      setState(() {
                        _selectedDate = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    eventLoader: _taskController.getEventsFromDay,
                  ),
                  ..._taskController.getEventsFromDay(_selectedDate).map(
                        (Task task) => ListTile(
                          textColor: Colors.green,
                          title: Text(task.title.toString()),
                        ),
                      )
                ],
              ),
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
                  color: cardListModel.spaceColor,
                ),
              ),
            ],
          ),
        ),
        PlusButton(spaceColor: cardListModel.spaceColor),
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

  addTaskBar(cardListModel) {
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
            spaceColor: cardListModel.spaceColor,
            onTap: () => {
              Get.to(
                () => AddTask(
                  name: 'ADD TASK',
                  cardColor: cardListModel.spaceColor,
                  userid: cardListModel.userid,
                ),
              )
            },
          )
        ],
      ),
    );
  }
}
