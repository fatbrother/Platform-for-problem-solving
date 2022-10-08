import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../context/firebase_options.dart';

class Database {
  static final Database _instance = Database._internal();
  factory Database() => _instance;
  Database._internal();

  final FirebaseApp _app = Firebase.app();

  FirebaseApp get app => _app;

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    var platform = DefaultFirebaseOptions.currentPlatform;
    await Firebase.initializeApp(options: platform);
  }
}