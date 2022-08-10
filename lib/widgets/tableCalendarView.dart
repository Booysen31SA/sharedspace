// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/models/task.dart';
import 'package:sharedspace/services/database.dart';
import 'package:sharedspace/widgets/eventCardList.dart';
import 'package:table_calendar/table_calendar.dart';
import '../globals.dart' as globals;

class TableCalendarView extends StatefulWidget {
  const TableCalendarView({Key? key}) : super(key: key);

  @override
  State<TableCalendarView> createState() => _TableCalendarViewState();
}

class _TableCalendarViewState extends State<TableCalendarView> {
  DateTime _selectedDate = globals.selectedDate;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.week;
  double listSize = 320;

  Map<DateTime, List<dynamic>> _events = {};

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
    return _events[DateTime(date.year, date.month, date.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    if (format == CalendarFormat.month) {
      listSize = format == CalendarFormat.month ? 320 : 500;
    } else {
      Timer timer = new Timer(new Duration(milliseconds: 500), () {
        setState(() {
          listSize = format == CalendarFormat.month ? 320 : 500;
        });
      });
    }

    return Expanded(
      child: Column(
        children: [
          StreamBuilder<List<TaskModel>>(
            stream: taskDBS.streamList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TaskModel>? allEvents = snapshot.data;
                if (allEvents!.isNotEmpty) {
                  _events = _groupEvents(allEvents);
                }
              }
              return TableCalendar(
                eventLoader: getEventsFromDay,
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
                  headerPadding:
                      EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15),
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
                  if (_format == CalendarFormat.month) {
                    listSize = _format == CalendarFormat.month ? 320 : 500;
                  } else {
                    Timer timer =
                        new Timer(new Duration(milliseconds: 500), () {
                      setState(() {
                        listSize = _format == CalendarFormat.month ? 320 : 500;
                      });
                    });
                  }
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                    globals.selectedDate = selectedDay;
                  });
                },
              );
            },
          ),
          _ListBuilder()
        ],
      ),
    );
  }

  _getBody() {
    return _events[DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day)] !=
            null
        ? _events[DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day)]!
            .map(
              (event) => EventCardList(
                event: new TaskModel(
                  title: event.title,
                  note: event.note,
                  date: event.date,
                ),
              ),
            )
            .toList()
        : [].toList();
  }

  _ListBuilder() {
    return SizedBox(
      height: listSize,
      child: _getBody().length > 0
          ? ListView(
              shrinkWrap: true,
              children: <Widget>[
                ..._getBody(),
              ],
            )
          : Center(
              child: Text('No Events'),
            ),
    );
  }
}
