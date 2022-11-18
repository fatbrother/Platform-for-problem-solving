import 'package:flutter/material.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Container(
              color: Colors.pink,
              padding: const EdgeInsets.all(10.0),
              child: Text(text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 18.0, color: Colors.white)),
            ),
          ),
          const Icon(Icons.person, size: 32)
        ],
      ),
    );
  }
}
