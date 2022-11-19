import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    required this.body,
    required this.onTap,
    required this.backgroundColor,
    required this.currentIndex,
  });

  final int currentIndex;
  final Color backgroundColor;
  final Widget body;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.secondaryColor,
      body: Column(
        children: [
          const MyAppBar(),
          body,
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
      ),
    );
  }
}
