import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const Color blueishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = blueishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color.fromRGBO(48, 48, 48, 0);

IconData backArrow = Icons.arrow_back_ios;
IconData add = Icons.add;

class Themes {
  static final light = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: primaryClr,
      brightness: Brightness.light);

  static final dark = ThemeData(
      backgroundColor: darkHeaderClr,
      primaryColor: primaryClr,
      brightness: Brightness.dark);
}

var calendarStyle = HeaderStyle(
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
  headerPadding: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 15),
);
