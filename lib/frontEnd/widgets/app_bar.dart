import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Design.getScreenHeight(context) * 0.04),
        Row(
          children: [
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.arrow_back),
              iconSize: 35,
            ),
          ],
        ),
      ],
    );
  }
}
