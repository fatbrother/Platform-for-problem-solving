import 'package:flutter/material.dart';
import 'context/routes.dart';
import 'back_end/database.dart';

void main() async {
  Database.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POPS',
      home: Routes.routes[Routes.home]!(context),
      routes: {
        for (final entry in Routes.routes.entries)
          entry.key: entry.value,
      },
    );
  }
}