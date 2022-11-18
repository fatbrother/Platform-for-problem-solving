import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';

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
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
        },
      ),
    );
  }

  static void showInfo(String title, String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Alert(
        title: title,
        content: Text(message),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static void showAlertDialog(BuildContext context, String message) {
    AlertDialog dialog = AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SizedBox(
          width: Design.getScreenWidth(context) * 0.8,
          height: Design.getScreenHeight(context) * 0.05,
          child: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Design.secondaryColor), // background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ))),
            child: const Text("確認",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black)),
            onPressed: () => Navigator.pop(context),
          ),
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );

    // Show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
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
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
