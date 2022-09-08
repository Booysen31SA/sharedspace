import 'package:flutter/material.dart';

StringToColor(color) {
  String valueString = color!.split('(0x')[1].split(')')[0]; // kind of hacky..
  int value = int.parse(valueString, radix: 16);
  Color otherColor = new Color(value);
  return otherColor;
}
