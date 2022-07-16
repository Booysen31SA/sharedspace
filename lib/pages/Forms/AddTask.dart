// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/widgets/input_field.dart';

class AddTask extends StatefulWidget {
  final String name;
  final Color cardColor;
  const AddTask({Key? key, required this.name, required this.cardColor})
      : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _selectedDate = DateTime.now();
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyInputField(title: 'Title', hint: 'Enter your title'),
                      MyInputField(title: 'Note', hint: 'Enter your note'),
                      MyInputField(
                        title: 'Date',
                        hint: DateFormat.yMd().format(_selectedDate),
                        widget: IconButton(
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () => {
                            _getDateFromUser(),
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child:
                                MyInputField(title: 'Start Time', hint: 'time'),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child:
                                MyInputField(title: 'End Time', hint: 'time'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
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
                backArrow,
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

  _getDateFromUser() async {
    DateTime? _pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2140),
    );

    if (_pickDate != null) {
      setState(() {
        _selectedDate = _pickDate;
      });
    } else {
      print('Something Went wrong with date Picker');
    }
  }
}
