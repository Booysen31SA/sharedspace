import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharedspace/services/notificationService.dart';
import 'package:sharedspace/services/themeService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var notifyHelper;

  @override
  void initState(){
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: const [
          Text("Theme data",
          style: TextStyle(
            fontSize: 30,
          ),)
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title: 'Themed changed',
            body: Get.isDarkMode?"Activated Light Mode": "Activated Dark Mode"
          );

          notifyHelper.scheduledNotification(
            title: 'Themed changed',
            body: Get.isDarkMode?"Activated Light Mode": "Activated Dark Mode"
          );
        },
        child: const Icon(Icons.nightlight_round,
        size: 20,
        ),
      ),
      actions: const [
       Icon(Icons.person,
        size: 20,
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}