import 'package:flutter/material.dart';

// this class is store the information of our design
// use this class to define all the details of our design
// for example, the color of the button, the color of the text, border radius, etc.
class Design {
  static const Color primaryColor = Color(0xFF4F809B);
  static const Color secondaryColor = Color(0x754F809B);
  static const Color backgroundColor = Color(0xFFD9D9D9);

  static const Color primaryTextColor = Colors.black;
  static const Color secondaryTextColor = Color.fromARGB(137, 11, 11, 11);

  static const outsideSpacing = EdgeInsets.only(
    top: 40,
    left: 20,
    right: 20,
    bottom: 20,
  );
  static const insideSpacing = EdgeInsets.all(10.0);
  static const outsideBorderRadius =
      BorderRadius.all(Radius.circular(20.0));
  static const insideBorderRadius =
      BorderRadius.all(Radius.circular(10.0));

  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
