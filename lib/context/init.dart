import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'firebase_options.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  var platform = DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(options: platform);
}