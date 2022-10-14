import 'package:flutter/material.dart';

// this class is store the information of our design
// use this class to define all the details of our design
// for example, the color of the button, the color of the text, border radius, etc.
class Design {
  static const Color _primaryColor = Colors.blue;
  static const Color _secondaryColor = Color(0xFF2E2E2E);
  static const Color _tertiaryColor = Color(0xFF3E3E3E);

  static Color get primaryColor => _primaryColor;
  static Color get secondaryColor => _secondaryColor;
  static Color get tertiaryColor => _tertiaryColor;
}