import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import '../backEnd/database/tag.dart';
import 'firebase_options.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'pops',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  TagsDatabase.init();
  // close the function of screen shot
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}
