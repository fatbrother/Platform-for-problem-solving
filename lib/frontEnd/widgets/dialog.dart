import 'package:flutter/material.dart';

import 'alert.dart';

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