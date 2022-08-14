import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Models/eventModel.dart';
import 'package:sharedspace/Services/database.dart';
import 'package:sharedspace/Services/service.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _selectedDate = DateService().selectedDate;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.week;

  Map<DateTime, List<dynamic>> _events = {};

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> events) {
    Map<DateTime, List<EventModel>> data = {};
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
    return Column(
      children: [
        StreamBuilder<List<EventModel>>(
          stream: eventDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel>? allEvents = snapshot.data;
              if (allEvents!.isNotEmpty) {
                _events = _groupEvents(allEvents);
              }
              rebuild();
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
              weekendDays: const [DateTime.saturday, DateTime.sunday],
              calendarFormat: format,
              headerStyle: calendarStyle,
              calendarStyle: const CalendarStyle(
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
                  DateService().changeDate(selectedDay);
                  _selectedDate = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            );
          },
        ),
        ..._getCurrentDayList()
      ],
    );
  }

  Future<bool> rebuild() async {
    if (!mounted) return false;

    // if there's a current frame,
    if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      // wait for the end of that frame.
      await SchedulerBinding.instance.endOfFrame;
      if (!mounted) return false;
    }

    setState(() {});
    return true;
  }

  _getCurrentDayList() {
    return _events[DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day)] !=
            null
        ? _events[DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day)]!
            .map((event) => Text(event.title))
            .toList()
        : [
            const Center(
              child: Text('No Events'),
            ),
          ].toList();
  }

  _listView() {
    return _getCurrentDayList().length > 0
        ? ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              ..._getCurrentDayList(),
            ],
          )
        : null;
  }
}
