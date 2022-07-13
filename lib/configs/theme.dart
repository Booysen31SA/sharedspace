import 'package:flutter/material.dart';

const Color blueishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = blueishClr;
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color.fromRGBO(48, 48, 48, 0);

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
