import 'package:flutter/material.dart';

import '../utilities/design.dart';

class SuggestField extends StatefulWidget {
  final String hintTextFloating;
  final TextEditingController controller;
  final bool obscureText;
  final int maxline;

  const SuggestField({
    super.key,
    required this.hintTextFloating,
    required this.controller,
    this.obscureText = false,
    this.maxline = 1,
  });

  @override
  State<SuggestField> createState() => _SuggestFieldState();
}

class _SuggestFieldState extends State<SuggestField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        TextField(
          maxLines: widget.maxline,
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            hintText: widget.hintTextFloating,
            hintStyle: const TextStyle(
              color: Design.backgroundColor,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          obscureText: widget.obscureText,
        ),
      ],
    );
  }
}

class ReportField extends StatefulWidget {
  final String hintTextFloating;
  final TextEditingController controller;
  final bool obscureText;
  final int maxline;

  const ReportField({
    super.key,
    required this.hintTextFloating,
    required this.controller,
    this.obscureText = false,
    this.maxline = 2,
  });

  @override
  State<ReportField> createState() => _ReportFieldState();
}

class _ReportFieldState extends State<ReportField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        TextField(
          maxLines: widget.maxline,
          controller: widget.controller,
          decoration: InputDecoration(
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            hintText: widget.hintTextFloating,
            hintStyle: const TextStyle(
              color: Design.backgroundColor,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          obscureText: widget.obscureText,
        ),
      ],
    );
  }
}
