import 'package:flutter/material.dart';

import '../../design.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const MainButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Design.primaryColor,
        padding: EdgeInsets.symmetric(
          horizontal: 0.3 * Design.getScreenWidth(context),
          vertical: 0.03 * Design.getScreenHeight(context),
        ),
        textStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(text),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        textScaleFactor: 1.5,
      ),
      onPressed: () => onPressed(),
    );
  }
}
