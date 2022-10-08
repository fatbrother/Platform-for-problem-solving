import 'package:flutter/material.dart';
import 'context/routes.dart';
import 'context/init.dart';

void main() {
  initialize();
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
      routes: Routes.routes,
    );
  }
}