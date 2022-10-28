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
    for (int i = 0; i < 5; i++) {
      if (i < widget.numOfStars) {
        stars.add(const Icon(
          Icons.star,
          color: Design.primaryColor,
        ));
      } else {
        stars.add(const Icon(
          Icons.star,
          color: Design.secondaryColor,
        ));
      }
    }

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          for (int i = 0; i < 5; i++)
            Align(
              alignment: Design.angleToAlignment(360 / 5 * i),
              child: stars[i],
            ),
        ],
      ),
    );
  }
}
