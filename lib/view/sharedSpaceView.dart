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
    print(arguments['groupid']);

    const List<Widget> _pages = <Widget>[
      CalendarView(),
      NoteView(),
    ];

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            print('Add Event'),
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
                Header(
                  prefixIcon: GestureDetector(
                    onTap: () => {
                      Navigator.pushReplacementNamed(context, '/home'),
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
                      Navigator.pushReplacementNamed(
                        context,
                        '/settings',
                        arguments: {
                          'isMain': false,
                          'groupid': arguments['groupid'],
                          'groupname': arguments['groupname']
                        },
                      ),
                    },
                  ),
                ),
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
