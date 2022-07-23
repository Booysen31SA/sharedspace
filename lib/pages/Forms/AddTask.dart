// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/services/themeService.dart';
import 'package:sharedspace/widgets/button.dart';
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = '09:00 AM';
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 30];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
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
                        MyInputField(
                          title: 'Title',
                          hint: 'Enter your title',
                          controller: _titleController,
                        ),
                        MyInputField(
                          title: 'Note',
                          hint: 'Enter your note',
                          controller: _noteController,
                        ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _colorPicker(),
                            MyButton(
                              label: 'Create Task',
                              onTap: () => _validateData(),
                              spaceColor: widget.cardColor,
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

  _colorPicker() {
    return Column(
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
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isEmpty) {
      //add to db
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        'All fields are reqired!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: Icon(
          Icons.warning_amber_rounded,
        ),
      );
    }
  }
}
