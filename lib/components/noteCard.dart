import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedspace/configs/themes.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: MediaQuery.of(context).size.width / 0.5,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          stops: [
            0.1,
            // 0.4,
            // 0.6,
            0.9,
          ],
          colors: [
            primaryClr,
            Colors.teal,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Matthew Booysen',
            style: notesListHeadingStyle,
          ),
          Row(
            children: [
              Text(
                'Title: ',
                style: notesListHeadingStyle,
              ),
              const Text(
                'This is a temp title',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Created on: ',
                style: notesListHeadingStyle,
              ),
              const Text(
                '20 September 2022',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
