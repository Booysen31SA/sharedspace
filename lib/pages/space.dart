// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/widgets/plusButton.dart';

class Space extends StatelessWidget {
  final String name;
  final Color cardColor;
  const Space({Key? key, required this.name, required this.cardColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              // header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.pop(context),
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
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
                  PlusButton(),
                ],
              )
              // dates row

              //todays tasks

              //appBar
              // utill function
            ],
          ),
        ),
      ),
    );
  }
}
