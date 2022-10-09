import 'package:flutter/material.dart';
import 'context/routes.dart';
import 'context/init.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initialize(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POPS',
      initialRoute: Routes.home,
      routes: Routes.routes,
      home: Routes.routes[Routes.home]!(context),
    );
  }
}