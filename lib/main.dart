import 'package:flutter/material.dart';
import 'context/routes.dart';

void main() {
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