// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final prefixIcon;
  final heading;
  final suffixIcon;
  final AppBar? appBar;
  const Header({
    Key? key,
    this.prefixIcon,
    this.heading,
    this.suffixIcon,
    this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAction = suffixIcon == null ? false : true;
    bool isLeading = prefixIcon == null ? false : true;

    return isLeading
        ? AppBar(
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
          )
        : AppBar(
            elevation: 0.0,
            titleSpacing: 0,
            backgroundColor: context.theme.backgroundColor,
            title: heading,
            actions: isAction
                ? <Widget>[
                    suffixIcon,
                    const SizedBox(
                      width: 15,
                    ),
                  ]
                : [],
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar!.preferredSize.height);
}
