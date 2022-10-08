import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'context/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var platform = DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(options: platform);
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