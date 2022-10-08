import 'package:flutter/material.dart';

const primaryClr = Color(0xFF4e5ae8);
const backgroundClrDark = Color.fromARGB(0, 255, 0, 0);
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

inputDecoration({hintText, color, suffixIcon, borderColor, isfocusBorder}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor ?? Colors.white),
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: isfocusBorder == null
          ? const BorderSide(color: Colors.white)
          : const BorderSide(color: primaryClr),
      borderRadius: const BorderRadius.all(
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

TextStyle get headingStyle {
  return const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get notesHeadingStyle {
  return const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get notesListHeadingStyle {
  return const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

TextStyle get settingSizes {
  return const TextStyle(
    fontSize: 20,
  );
}
