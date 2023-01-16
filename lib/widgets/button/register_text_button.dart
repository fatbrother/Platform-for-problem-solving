import 'package:flutter/material.dart';

class RegisterTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const RegisterTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        textScaleFactor: 1.5,
      ),
    );
  }
}