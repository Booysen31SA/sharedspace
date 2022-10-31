import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/services/functions.dart';
import 'package:sharedspace/services/services.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  final String groupid;
  final double height;
  const CalendarView({Key? key, required this.groupid, required this.height})
      : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.week;
  DateTime _selectedDate = DateTimeService().date;
  double listSize = 320;
  double height = 150;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: getTableCalenderEvents(widget.groupid),
          builder: (context, snapshot) {
            return SizedBox(
              height: height,
              child: TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                shouldFillViewport: true,
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
                headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: false,
                  formatButtonShowsNext: false,
                  formatButtonDecoration: BoxDecoration(
                    color: primaryClr,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  formatButtonTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  headerPadding:
                      const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15),
                ),
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
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                    DateTimeService().changeSelectedDate(selectedDay);
                  });
                },
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    if (_format == CalendarFormat.week) {
                      height = 150;
                    } else {
                      height = 400;
                    }
                    format = _format;
                  });
                },
              ),
            );
          },
        ),
        Center(
          child: GestureDetector(
              onPanUpdate: (details) {
                onDrag(details.delta.dx, details.delta.dy);
              },
              child: Text('test Drag')),
        )
      ],
    );
  }

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;

    if (newHeight > 150 && newHeight < 400) {
      setState(() {
        if (newHeight < 170) {
          format = CalendarFormat.week;
        } else {
          format = CalendarFormat.month;
        }
        height = newHeight;
      });
    }
  }
}
