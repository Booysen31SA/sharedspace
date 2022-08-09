// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, unnecessary_string_interpolations, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/models/task.dart';
import 'package:sharedspace/services/database.dart';
import '../../globals.dart' as globals;
import 'package:get/get.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  //controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noterController = TextEditingController();
  DateTime _selectedDate = globals.selectedDate;

  get primaryClr => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(context),
                SizedBox(
                  height: 10,
                ),
                // Titler
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.title),
                    hintText: 'Enter Title',
                    labelText: 'Title',
                  ),
                  validator: ((value) =>
                      validate(value, 'Please enter a valid title')),
                ),

                //notes
                TextFormField(
                  controller: _noterController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.title),
                    hintText: 'Enter note',
                    labelText: 'Note',
                  ),
                  // validator: ((value) =>
                  //     validate(value, 'Please enter a valid note')),
                ),

                // date
                TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.calendar_month),
                      hintText: '${DateFormat.yMd().format(_selectedDate)}',
                    ),
                    onTap: () => {
                          _getDateFromUser(),
                        })
              ],
            ),
          ),
        ),
      ),
    );
  }

  validate(value, errorMessage) {
    if (value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  header(context) {
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
                Icons.cancel_sharp,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Add Event',
                style: TextStyle(
                  fontSize: 26,
                  color: primaryClr,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          child: Icon(Icons.check),
          onTap: () async => {
            print('Saving....'),
            await taskDBS.create(
              TaskModel(
                title: _titleController.text,
                note: _noterController.text,
                date: DateFormat('yyyy-MM-dd').parse(_selectedDate.toString()),
              ).toMap(),
            ),
            Get.back(),
          },
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2140),
    );

    if (pickDate != null) {
      setState(() {
        _selectedDate = pickDate;
      });
    } else {
      _selectedDate = globals.selectedDate;
      print('Something Went wrong with date Picker');
    }
  }
}
