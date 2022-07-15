// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sharedspace/pages/home.dart';
import 'package:sharedspace/pages/loading.dart';
import 'package:sharedspace/screen/home_page.dart';
import 'package:sharedspace/services/themeService.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'configs/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
        initialRoute: '/',
        routes: {
          '/': (context) => Loading(),
          '/home': (context) => Home(),
        });
  }
}
