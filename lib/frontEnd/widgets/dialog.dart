import 'package:flutter/material.dart';

class DialogManager {
  static void showError(Object e, BuildContext context) {
    String message = 'An error occurred';
    try {
      message = e.toString();
      message = message.substring(message.indexOf(':') + 1);
    } catch (e) {
      // ignore
    }

    showDialog(
      context: context,
      builder: (context) => Alert(
        title: 'Error',
        content: Text(message),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  static void showInfo(String title, String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Alert(
        title: title,
        content: Text(message),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

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
