import 'package:flutter/material.dart';

stringToColor(String color) {
  String valueString = color.split('(0x')[1].split(')')[0]; // kind of hacky..
  int value = int.parse(valueString, radix: 16);
  Color otherColor = Color(value);
  return otherColor;
}
