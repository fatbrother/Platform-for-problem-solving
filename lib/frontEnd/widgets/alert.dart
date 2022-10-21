import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({
    Key? key,
    this.title = "Error",
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final Widget content;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}