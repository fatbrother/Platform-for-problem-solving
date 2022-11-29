import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';

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
          Routes.back(context);
        },
      ),
    );
  }

  static void showInfoDialog(BuildContext context, String message) {
    AlertDialog dialog = AlertDialog(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SizedBox(
          width: Design.getScreenWidth(context) * 0.8,
          height: Design.getScreenHeight(context) * 0.04,
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
            onPressed: () => Routes.back(context),
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

  static void showContentDialog(
      BuildContext context, Widget content, void Function() onPressed) {
    AlertDialog dialog = AlertDialog(
      backgroundColor: Design.insideColor,
      actionsPadding: const EdgeInsets.all(0),
      content: Center(heightFactor: 0.5, child: content),
      actions: <Widget>[
        SizedBox(
          height: Design.getScreenHeight(context) * 0.04,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Design.secondaryColor), // background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ))),
                  onPressed: () {
                    onPressed();
                    Routes.back(context);
                  },
                  child: const Text("確認",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Design.generalTagColor), // background color
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20),
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ))),
                  child: const Text("取消",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black)),
                  onPressed: () => Routes.back(context),
                ),
              ),
            ],
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
            onPressed;
            Routes.back(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
