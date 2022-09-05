import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
          create: (context) => context.read<FlutterFireAuthService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'SharedSpace',
        
        // Theme changes

        // Routing
      );
    );
  }
}