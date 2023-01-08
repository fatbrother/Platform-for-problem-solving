import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pops/utilities/design.dart';

class ShowLableWidget extends StatelessWidget {
  final String title;
  final bool isGeneral;
  const ShowLableWidget({
    super.key,
    required this.title,
    required this.isGeneral,
  });
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SvgPicture.asset(
        'assets/label_left_triangle.svg',
        color: isGeneral ? Design.generalTagColor : Design.systemTagColor,
      ),
      Container(
        height: 24.2,
        padding: const EdgeInsets.symmetric(horizontal: 3.4, vertical: 3.1),
        color: isGeneral ? Design.generalTagColor : Design.systemTagColor,
        child: Container(
          color: Design.insideColor,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ),
    ]);
  }
}
