// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddTask extends StatefulWidget {
  final String name;
  final Color cardColor;
  const AddTask({Key? key, required this.name, required this.cardColor})
      : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              // header
              header(context, widget.name, widget.cardColor),
              //
            ],
          ),
        ),
      ),
    );
  }

  header(context, name, cardColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.pop(context),
          },
          child: Row(
            children: [
              Icon(
                Icons.arrow_back,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$name',
                style: TextStyle(
                  fontSize: 26,
                  color: cardColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
