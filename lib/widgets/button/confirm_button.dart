import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class ConfirmButtom extends StatelessWidget {
  final void Function() onPressed;
  final String name;

  const ConfirmButtom({
    Key? key,
    required this.onPressed,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: Design.spacing,
          elevation: 0,
          backgroundColor: Design.secondaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}
