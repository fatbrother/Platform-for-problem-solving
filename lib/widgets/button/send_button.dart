import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class SendButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const SendButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(150, 45),
        backgroundColor: Design.secondaryColor,
        foregroundColor: Design.primaryTextColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        side: const BorderSide(
          color: Design.secondaryColor,
          width: 1,
        ),
      ),
      child: Text(
        text,
        textScaleFactor: 1.5,
      ),
    );
  }
}