import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import '../backEnd/database/tag.dart';
import 'design.dart';
import 'firebase_options.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

Future<void> initialize(BuildContext context) async {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  BoxConstraints constraints = BoxConstraints(
    maxWidth: screenWidth,
    maxHeight: screenHeight,
  );
  Design.init(constraints, MediaQuery.of(context).orientation);
  TagsDatabase.init();
  WidgetsFlutterBinding.ensureInitialized();
  var platform = DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(options: platform);
  // close the function of screen shot
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
}
