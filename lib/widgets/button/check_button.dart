import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class CheckButton extends StatelessWidget {
  final bool ischeck;
  final String text;
  final Color backgroundColor;
  final void Function() onPressed;

  const CheckButton({
    super.key,
    required this.ischeck,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(370, 40),
        backgroundColor: Colors.white,
        foregroundColor: Design.primaryTextColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        side: const BorderSide(
          color: Design.secondaryColor,
          width: 0,
        ),
      ),
      child: Row(
        children: [
          Icon(ischeck
              ? Icons.check_circle_outline
              : Icons.radio_button_unchecked),
          SizedBox(width: Design.getScreenHeight(context) * 0.015),
          Text(
            text,
            textScaleFactor: 1.5,
          ),
        ],
      ),
    );
  }
}
