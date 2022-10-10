import 'package:flutter/material.dart';

class Design {
  static const Color _primaryColor = Colors.blue;
  static const Color _secondaryColor = Color(0xFF2E2E2E);
  static const Color _tertiaryColor = Color(0xFF3E3E3E);

  static double _screenWidth = 0.0;
  static double _screenHeight = 0.0;

  static void init(double screenWidth, double screenHeight) {
    _screenWidth = screenWidth;
    _screenHeight = screenHeight;
  }

  static Color get primaryColor => _primaryColor;
  static Color get secondaryColor => _secondaryColor;
  static Color get tertiaryColor => _tertiaryColor;

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
}