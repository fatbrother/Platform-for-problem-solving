import 'package:flutter/material.dart';
import 'package:pops/context/init.dart';
import 'package:pops/context/routes.dart';
import 'register.dart';

void main(){
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
      routes: Routes.routes,
      home: Routes.routes[Routes.home]!(context),
    );
  }
}