import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/widgets/button/color_button.dart';

class ShowLabelBoxWidget extends StatelessWidget {
  final String label;
  final String leftButtonTitle;
  final void Function() leftButtonOnPressed;
  final String rightButtonTitle;
  final void Function() rightButtonOnPressed;

  const ShowLabelBoxWidget({
    super.key,
    required this.label,
    required this.leftButtonTitle,
    required this.leftButtonOnPressed,
    required this.rightButtonTitle,
    required this.rightButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Design.getScreenHeight(context) * 0.05,
          decoration: const BoxDecoration(
            color: Design.insideColor,
          ),
          child: Stack(
            children: [
              Container(
                alignment: const Alignment(-1, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Design.primaryTextColor,
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(0.4, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ColorButton(
                  title: leftButtonTitle,
                  backgroundColor: const Color.fromARGB(136, 160, 182, 195),
                  onPressed: leftButtonOnPressed,
                ),
              ),
              Container(
                alignment: const Alignment(1, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ColorButton(
                  title: rightButtonTitle,
                  backgroundColor: const Color.fromARGB(255, 212, 199, 198),
                  onPressed: rightButtonOnPressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
