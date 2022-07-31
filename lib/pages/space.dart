// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/models/cardListModel.dart';
import 'package:sharedspace/models/task.dart';
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
  Map<DateTime, List<dynamic>> _events = {};
  List<dynamic> _selectedEvents = [];

  Map<DateTime, List<dynamic>> _groupEvents(List<TaskModel> events) {
    Map<DateTime, List<TaskModel>> data = {};
    for (var event in events) {
      DateTime date =
          DateTime(event.date.year, event.date.month, event.date.day);
      if (data[date] == null) data[date] = [];
      data[date]!.add(event);
    }
    return data;
  }

  List<dynamic> getEventsFromDay(DateTime date) {
    //2022-07-30 00:00:00.000Z
    var test = _events[DateTime(date.year, date.month, date.day)];
    return _events[DateTime(date.year, date.month, date.day)] ?? [];
  }

  _getBody() {
    return _events[DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day)] !=
            null
        ? _events[DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day)]!
            .map(
            (e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(e.title.toString()),
              ],
            ),
          )
        : [];
  }

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
                  StreamBuilder<List<TaskModel>>(
                    stream: eventDBS.streamList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<TaskModel>? allEvents = snapshot.data;
                        if (allEvents!.isNotEmpty) {
                          _events = _groupEvents(allEvents);
                        }
                      }
                      return Column(
                        children: [
                          TableCalendar(
                            eventLoader: getEventsFromDay,
                            focusedDay: _focusedDay,
                            firstDay: DateTime(2022),
                            lastDay: DateTime(2090),
                            formatAnimationDuration:
                                const Duration(milliseconds: 500),
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month',
                              CalendarFormat.week: 'Week',
                            },
                            //formatAnimationCurve: Curves.linear,
                            weekendDays: const [
                              DateTime.saturday,
                              DateTime.sunday
                            ],
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
                              headerPadding:
                                  EdgeInsets.only(top: 20.0, bottom: 20.0),
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
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDate = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            },
                          ),
                          ..._getBody()
                        ],
                      );
                    },
                  ),
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
}
