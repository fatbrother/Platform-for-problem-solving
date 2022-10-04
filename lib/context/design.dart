import 'package:flutter/material.dart';

class Design {
  static const Color _primaryColor = Colors.blue;
  static const Color _secondaryColor = Color(0xFF2E2E2E);
  static const Color _tertiaryColor = Color(0xFF3E3E3E);

  static const double _baseWidth = 375.0;
  static const double _baseHeight = 812.0;

  static double _screenWidth = 0.0;
  static double _screenHeight = 0.0;

  static double _scaleFactor = 1.0;
  static double _scaleFactorWidth = 1.0;
  static double _scaleFactorHeight = 1.0;

  static double _statusBarHeight = 0.0;
  static double _bottomBarHeight = 0.0;


  static void init(BoxConstraints constraints, Orientation orientation) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    if (orientation == Orientation.portrait) {
      _scaleFactorWidth = _screenWidth / _baseWidth;
      _scaleFactorHeight = _screenHeight / _baseHeight;
    } else {
      _scaleFactorWidth = _screenWidth / _baseHeight;
      _scaleFactorHeight = _screenHeight / _baseWidth;
    }

    _scaleFactor = (_scaleFactorWidth + _scaleFactorHeight) / 2;

    _statusBarHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;
    _bottomBarHeight = MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.bottom;
  }

  static Color get primaryColor => _primaryColor;
  static Color get secondaryColor => _secondaryColor;
  static Color get tertiaryColor => _tertiaryColor;

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;

  static double get scaleFactor => _scaleFactor;
  static double get scaleFactorWidth => _scaleFactorWidth;
  static double get scaleFactorHeight => _scaleFactorHeight;

  static double get statusBarHeight => _statusBarHeight;
  static double get bottomBarHeight => _bottomBarHeight;
}