import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class SelectButton extends StatelessWidget {
  final bool isOn;
  final Function() onChanged;
  final List<Widget> children;

  const SelectButton({
    super.key,
    required this.isOn,
    required this.onChanged,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Design.getScreenWidth(context) * 0.135,
      height: Design.getScreenHeight(context) * 0.04,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: isOn ? Design.primaryColor : Design.insideColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: Design.outsideBorderRadius,
          ),
        ),
        onPressed: onChanged,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
