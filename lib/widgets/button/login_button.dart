import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0.8 * Design.getScreenWidth(context),
            0.08 * Design.getScreenHeight(context)),
        backgroundColor: Design.primaryColor,
        padding: EdgeInsets.symmetric(
          vertical: 0.02 * Design.getScreenHeight(context),
        ),
        textStyle: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(text),
    );
  }
}
