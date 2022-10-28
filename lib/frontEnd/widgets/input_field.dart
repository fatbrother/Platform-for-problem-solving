import 'package:flutter/material.dart';

import '../design.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.hintText,
              textScaleFactor: 1.5,
              style: const TextStyle(
                color: Design.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.hintText,
            labelStyle: const TextStyle(
              color: Design.primaryColor,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          obscureText: widget.obscureText,
        ),
      ],
    );
  }
}
