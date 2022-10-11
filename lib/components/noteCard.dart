import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedspace/configs/themes.dart';

class NoteCard extends StatelessWidget {
  final String? createdBy;
  final String? title;
  final String? created;
  const NoteCard({super.key, this.createdBy, this.title, this.created});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
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
          // arrow that show up or down

          Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   'Title: ',
              //   style: notesListHeadingStyle,
              // ),
              Text(
                title!,
                style: notesStyle,
              ),
            ],
          ),

          const SizedBox(
            height: 10,
          ),

          Row(children: [
            Text(
              'Created by: ',
              style: notesListHeadingStyle,
            ),
            Text(
              createdBy!,
              style: notesListHeadingStyle,
            ),
          ]),

          Row(
            children: [
              Text(
                'Created on: ',
                style: notesListHeadingStyle,
              ),
              Text(
                created!.toString(),
                style: const TextStyle(
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
