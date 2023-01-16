import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class ColorButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final void Function() onPressed;

  const ColorButton({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(0.0),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Design.primaryTextColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
