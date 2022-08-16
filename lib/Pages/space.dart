// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Pages/Forms/addEvent.dart';
import 'package:sharedspace/Pages/Views/calendarView.dart';
import 'package:sharedspace/Pages/Views/noteView.dart';
import 'package:sharedspace/Services/service.dart';
import 'package:sharedspace/Widgets/IconButton.dart';

class Space extends StatefulWidget {
  const Space({
    Key? key,
  }) : super(key: key);

  @override
  State<Space> createState() => _SpaceState();
}

class _SpaceState extends State<Space> {
  var cardListModel = Get.arguments;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = <Widget>[
      CalendarView(),
      NoteView(),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryClr,
        child: IconButtonCustom(
          color: primaryClr,
          icon: add,
          size: 30,
        ),
        onPressed: () => {
          Get.to(
            () => const AddEvent(),
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              header(context, cardListModel),
              IndexedStack(
                index: _selectedIndex,
                children: _pages,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: primaryClr,
        selectedLabelStyle: ThemeService().subHeading,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.grey[400],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calandar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_sharp),
            label: 'Notes',
          )
        ],
      ),
    );
  }

  header(context, cardListModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => {
            Get.back(),
          },
          child: Row(
            children: [
              Icon(
                backArrow,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                '${cardListModel.firstName} ${cardListModel.surname}',
                style: const TextStyle(
                  fontSize: 20,
                  color: primaryClr,
                ),
              ),
            ],
          ),
        ),
        const IconButtonCustom(
          color: primaryClr,
          icon: Icons.more_vert_rounded,
          size: 30,
        ),
      ],
    );
  }
}
