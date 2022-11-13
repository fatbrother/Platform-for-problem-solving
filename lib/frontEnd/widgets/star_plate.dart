import 'dart:math';

import 'package:flutter/material.dart';

import '../design.dart';

class StarPlate extends StatefulWidget {
  final int numOfStars;
  final double size;

  const StarPlate({
    super.key,
    required this.numOfStars,
    required this.size,
  });

  @override
  State<StarPlate> createState() => _StarPlateState();
}

class _StarPlateState extends State<StarPlate> {
  List<Widget> stars = [];

  @override
  Widget build(BuildContext context) {
    stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < widget.numOfStars) {
        stars.add(const Icon(
          Icons.star,
          size: 70,
          color: Design.primaryColor,
        ));
      } else {
        stars.add(const Icon(
          Icons.star,
          size: 70,
          color: Design.secondaryColor,
        ));
      }
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: <Widget>[
          for (int i = 0; i < 5; i++)
            Align(
              alignment: Design.angleToAlignment((pi / 2) * 3 + 2 * pi / 5 * i),
              child: stars[i],
            ),
        ],
      ),
    );
  }
}
