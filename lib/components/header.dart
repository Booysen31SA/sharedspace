// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  final prefixIcon;
  final heading;
  final suffixIcon;
  const Header({
    Key? key,
    this.prefixIcon,
    this.heading,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAction = suffixIcon == null ? false : true;
    bool isLeading = prefixIcon == null ? false : true;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: AppBar(
        elevation: 0.0,
        titleSpacing: 0,
        backgroundColor: context.theme.backgroundColor,
        leading: isLeading ? prefixIcon : Container(),
        title: heading,
        actions: isAction
            ? <Widget>[
                suffixIcon,
                const SizedBox(
                  width: 15,
                ),
              ]
            : [],
      ),
    );
  }
}
