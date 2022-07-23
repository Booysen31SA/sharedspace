// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sharedspace/configs/theme.dart';
import 'package:sharedspace/pages/home.dart';
import 'package:sharedspace/services/themeService.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              // header
              header(
                context,
                'Settings',
                primaryClr,
              ),

              darkModeSettings(),
            ],
          ),
        ),
      ),
    );
  }

  header(context, name, spaceColor) {
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
              SizedBox(
                width: 10,
              ),
              Text(
                '$name',
                style: TextStyle(
                  fontSize: 26,
                  color: spaceColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  darkModeSettings() {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Dark Mode',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Switch.adaptive(
          value: Get.isDarkMode,
          onChanged: (value) => {
            ThemeService().switchTheme(),
          },
        )
      ]),
    );
  }
}
