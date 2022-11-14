import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    this.title = "Error",
    required this.content,
    required this.onPressed,
  });

  final String title;
  final Widget content;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
