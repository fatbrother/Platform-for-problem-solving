// Start of the app
// We don't need to change anything here

import 'package:flutter/material.dart';
import 'context/routes.dart';
import 'context/init.dart';

Future<void> main() async {
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POPS',
      initialRoute: Routes.home,
      routes: Routes.routes,
      home: Routes.routes[Routes.home]!(context),
    );
  }
}
