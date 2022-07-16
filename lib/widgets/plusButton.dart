// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedspace/configs/theme.dart';

class PlusButton extends StatelessWidget {
  final cardColor;
  const PlusButton({Key? key, this.cardColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
    );
  }
}
