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
        minimumSize: Size(0.8 * Design.getScreenWidth(context), 0.08 * Design.getScreenHeight(context)),
        backgroundColor: Design.primaryColor,
        padding: EdgeInsets.symmetric(
          vertical: 0.02 * Design.getScreenHeight(context),
        ),
        textStyle: const TextStyle(
          fontSize: 32.0,
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
