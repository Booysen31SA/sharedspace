import 'package:flutter/material.dart';

const primaryClr = Color(0xFF4e5ae8);
const backgroundClrDark = Color.fromRGBO(48, 48, 48, 0);
const backgroundClrLight = Colors.white;

IconData backArrow = Icons.arrow_back_ios;
IconData add = Icons.add;

class Themes {
  static final light = ThemeData(
      backgroundColor: backgroundClrLight,
      primaryColor: primaryClr,
      brightness: Brightness.light);

  static final dark = ThemeData(
      backgroundColor: backgroundClrDark,
      primaryColor: primaryClr,
      brightness: Brightness.dark);
}

inputDecoration({hintText, color, suffixIcon}) {
  return InputDecoration(
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    fillColor: color,
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey[500]),
    labelStyle: const TextStyle(color: Colors.white),
    suffixIcon: suffixIcon,
  );
}
