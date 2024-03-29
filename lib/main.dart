// Start of the app
// We don't need to change anything here

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:pops/services/other/tag.dart';
import 'utilities/firebase_options.dart';
import 'utilities/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  TagsDatabase.instance.init();
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
      home: Routes.homeRoute!(context),
    );
  }
}
