// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/services/themeService.dart';
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
  String _endTime = '09:00 AM';
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 30];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
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
                              child: MyInputField(
                                title: 'Start Time',
                                hint: _startTime,
                                widget: IconButton(
                                  onPressed: () {
                                    _getTimeFromUser(isStartTime: true);
                                  },
                                  icon: Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: MyInputField(
                                title: 'End Time',
                                hint: _endTime,
                                widget: IconButton(
                                  onPressed: () {
                                    _getTimeFromUser(isStartTime: false);
                                  },
                                  icon: Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        MyInputField(
                          title: 'Reminder',
                          hint: '$_selectedRemind minutes early',
                          widget: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            style: subTitleStyle,
                            underline: Container(height: 0),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRemind = int.parse(newValue!);
                              });
                            },
                            items: remindList
                                .map<DropdownMenuItem<String>>((int value) {
                              return DropdownMenuItem(
                                value: value.toString(),
                                child: Text(
                                  value.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        MyInputField(
                          title: 'Repeat',
                          hint: '$_selectedRepeat',
                          widget: DropdownButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ),
                            iconSize: 32,
                            elevation: 4,
                            style: subTitleStyle,
                            underline: Container(height: 0),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRepeat = newValue!;
                              });
                            },
                            items: repeatList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem(
                                value: value.toString(),
                                child: Text(
                                  value.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Color',
                                  style: titleStyle,
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Wrap(
                                  children:
                                      List<Widget>.generate(3, (int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: index == 0
                                              ? primaryClr
                                              : index == 1
                                                  ? pinkClr
                                                  : yellowClr),
                                    );
                                  }),
                                )
                              ],
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

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();

    if (pickedTime == null) {
      print('Time Cancelled');
    } else if (isStartTime) {
      setState(() {
        String _formattedTime = pickedTime.format(context);
        _startTime = _formattedTime;
      });
    } else {
      setState(() {
        String _formattedTime = pickedTime.format(context);
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(
          _startTime.split(':')[0],
        ),
        minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
      ),
    );
  }
}
