import 'package:flutter/material.dart';
import 'package:pops/frontEnd/routes.dart';

class MyAppBar {
  static AppBar titleAppBar({required String title}) {
    return AppBar(
      //build arrow_back
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromARGB(255, 0, 0, 0),
            onPressed: () => Routes.back(context),
          );
        },
      ),
      //AppBar color and word
      backgroundColor: const Color.fromARGB(222, 255, 255, 255),
      title: Text(title, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
      centerTitle: true,
    );
  }
}