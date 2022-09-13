import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Calander Section'),
    );
  }
}
