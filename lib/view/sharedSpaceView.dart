import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/components/header.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/view/sub_views/calendarView.dart';
import 'package:sharedspace/view/sub_views/noteView.dart';

class SharedSpaceView extends StatefulWidget {
  const SharedSpaceView({
    Key? key,
  }) : super(key: key);

  @override
  State<SharedSpaceView> createState() => _SharedSpaceState();
}

class _SharedSpaceState extends State<SharedSpaceView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // spit between calander view and notes view
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    //print(arguments['groupid']);

    List<Widget> _pages = <Widget>[
      const CalendarView(),
      NoteView(
        groupid: arguments['groupid'],
      ),
    ];

    return Scaffold(
        appBar: Header(
          appBar: AppBar(),
          prefixIcon: GestureDetector(
            onTap: () => {
              Navigator.pop(context),
            },
            child: Icon(backArrow, color: primaryClr),
          ),
          heading: Text(
            arguments['groupname'],
            style: const TextStyle(
              fontSize: 26,
              color: primaryClr,
            ),
          ),
          suffixIcon: GestureDetector(
            child: const Icon(
              Icons.settings,
              color: primaryClr,
            ),
            onTap: () => {
              Navigator.pushNamed(
                context,
                '/settings',
                arguments: {
                  'isMain': false,
                  'isprofile': arguments['isprofile'] ?? false,
                  'groupid': arguments['groupid'],
                  'groupname': arguments['groupname']
                },
              ),
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            if (_selectedIndex == 0)
              {
                Navigator.pushNamed(context, '/creation', arguments: {
                  'creationtitle': 'Create Calander event',
                  'screen': 'calander'
                }),
              }
            else if (_selectedIndex == 1)
              {
                Navigator.pushNamed(context, '/creation', arguments: {
                  'creationtitle': 'Create a note',
                  'screen': 'note',
                  'groupid': arguments['groupid']
                }),
              }
          },
          backgroundColor: primaryClr,
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                IndexedStack(
                  index: _selectedIndex,
                  children: _pages,
                )
              ],
            ),
          ),
        ),

        // Bottom navigation
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              //canvasColor: context.theme.backgroundColor,
              ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: primaryClr,
            selectedLabelStyle: headingStyle,
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
        ));
  }
}
