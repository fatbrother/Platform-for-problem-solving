import 'package:flutter/material.dart';

import '../design.dart';

class MainButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const MainButton({
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
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(text),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  const SecondaryButton({
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
        ));
  }
}
