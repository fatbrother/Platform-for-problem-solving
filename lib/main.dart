// Start of the app
// We don't need to change anything here

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'firebase_options.dart';
import 'routes.dart';

Future<void> main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POPS',
      routes: Routes.routes,
      home: Routes.routes[Routes.login]!(context),
    );
  }
}
