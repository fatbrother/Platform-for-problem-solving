import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class SettingBar extends StatelessWidget {
  final void Function() onPressed;
  final String name;

  const SettingBar({
    Key? key,
    required this.onPressed,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => onPressed(),
      child: Container(
        width: double.infinity,
        height: Design.getScreenHeight(context) * 0.048,
        decoration: BoxDecoration(
          color: Design.insideColor,
          borderRadius:
              BorderRadius.circular(Design.getScreenHeight(context) * 0.05),
        ),
        child: Stack(
          children: [
            Center(
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: Design.getScreenWidth(context) * 0.05),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
