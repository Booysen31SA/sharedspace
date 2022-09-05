import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sharedspace/configs/themes.dart';
import 'package:sharedspace/database/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sharedspace/services/services.dart';
import 'package:sharedspace/view/auth/registerView.dart';
import 'package:sharedspace/view/auth/signInView.dart';
import 'package:sharedspace/view/homeView.dart';
import 'package:sharedspace/view/loadingView.dart';
import 'package:sharedspace/view/settings.dart';
import 'package:sharedspace/view/sharedSpaceView.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FlutterFireAuthService>(
          create: (_) => FlutterFireAuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<FlutterFireAuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: GetMaterialApp(
        title: 'SharedSpace',
        debugShowCheckedModeBanner: false,
        // Theme changes
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeService().theme,
        // form locals
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
        // Routing
        home: const LoadingView(),
        routes: {
          '/signin': (context) => SignInView(),
          '/register': (context) => RegisterView(),
          '/home': (context) => HomeView(),
          '/settings': (context) => SettingView(),
          '/sharedspace': (context) => SharedSpaceView()
        },
      ),
    );
  }
}
