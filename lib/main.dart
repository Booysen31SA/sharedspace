import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/Configs/themes.dart';
import 'package:sharedspace/Models/userModel.dart';
import 'package:sharedspace/Pages/Auth/Signin.dart';
import 'package:sharedspace/Pages/space.dart';
import 'package:sharedspace/Services/auth.dart';
import 'package:sharedspace/Services/service.dart';
import 'package:sharedspace/pages/home.dart';

// pages
import 'package:sharedspace/pages/loading.dart';
import 'package:sharedspace/pages/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  DateService().changeDate(DateTime.now());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().userStream,
      initialData: null,
      child: GetMaterialApp(
          title: 'Shared Space',
          debugShowCheckedModeBanner: false,
          // themes of the app
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: ThemeService().theme,
          initialRoute: '/',
          routes: {
            '/': (context) => const Loading(),
            '/signin': (context) => const SignIn(),
            '/home': (context) => const Home(),
            '/settings': (context) => const Settings(),
            '/space': (context) => const Space()
          }),
    );
  }
}
