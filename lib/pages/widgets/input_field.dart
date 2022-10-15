import 'package:flutter/material.dart';

import '../../context/design.dart';

class InputField extends StatelessWidget {
  final String hintText;

  const InputField({
    Key? key,
    required this.hintText,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              hintText,
              textScaleFactor: 1.5,
              style: const TextStyle(
                color: Design.primaryColor,
              ),
            ),
          ],
        ),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(
              color: Design.primaryColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ],
    );
  }
}
