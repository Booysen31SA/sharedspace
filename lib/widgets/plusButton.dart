// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final spaceColor;
  const PlusButton({Key? key, this.spaceColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
      decoration: BoxDecoration(
        color: spaceColor,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    );
  }
}
