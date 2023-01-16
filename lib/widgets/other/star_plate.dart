import 'dart:math';
import 'package:flutter/material.dart';
import '../../utilities/design.dart';

class StarPlate extends StatefulWidget {
  final int numOfStars;
  final double radius;
  final void Function() onPressed;

  const StarPlate({
    super.key,
    required this.numOfStars,
    required this.radius,
    required this.onPressed,
  });

  @override
  State<StarPlate> createState() => _StarPlateState();
}

class _StarPlateState extends State<StarPlate> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundColor: Design.insideColor,
        child: SizedBox(
          width: widget.radius * 1.9,
          height: widget.radius * 1.9,
          child: Stack(
            children: <Widget>[
              for (int i = 0; i < 5; i++)
                Align(
                  alignment: angleToAlignment((pi / 2) * 3 + 2 * pi / 5 * i),
                  child: Icon(
                    Icons.star,
                    size: widget.radius * 0.7,
                    color: i < widget.numOfStars
                        ? Design.primaryColor
                        : Design.secondaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Alignment angleToAlignment(double angle) {
    var radius = 1.0;
    var x = radius * cos(angle);
    var y = radius * sin(angle);

    return Alignment(x, y);
  }
}
