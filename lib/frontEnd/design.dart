import 'dart:math';

import 'package:flutter/material.dart';

// this class is store the information of our design
// use this class to define all the details of our design
// for example, the color of the button, the color of the text, border radius, etc.
class Design {
  static const Color primaryColor = Color(0xFF4F809B);
  static const Color secondaryColor = Color.fromARGB(255, 177, 193, 201);
  static const Color backgroundColor = Color(0xFFD9D9D9);
  static const Color insideColor = Color(0xFFEFEFEF);

  static const Color primaryTextColor = Colors.black;
  static const Color secondaryTextColor = Color.fromARGB(137, 11, 11, 11);

  static const spacing = EdgeInsets.all(10.0);
  static const outsideBorderRadius =
      BorderRadius.all(Radius.circular(20.0));
  static const insideBorderRadius =
      BorderRadius.all(Radius.circular(10.0));

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Alignment angleToAlignment(double angle) {
    var radius = 1.0;
    var x = radius * cos(angle);
    var y = radius * sin(angle);

    return Alignment(x, y);
  }
}