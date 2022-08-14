import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sharedspace/Models/eventModel.dart';
import 'package:sharedspace/Services/database.dart';
import 'package:sharedspace/Services/service.dart';

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
  DateTime _selectedDate = DateService().selectedDate;

  get primaryClr => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(context),
                const SizedBox(
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
                      hintText: DateFormat.yMd().format(_selectedDate),
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
              const Icon(
                Icons.cancel_sharp,
              ),
              const SizedBox(
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
            await eventDBS.create(
              EventModel(
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
      _selectedDate = DateService().selectedDate;
      print('Something Went wrong with date Picker');
    }
  }
}
