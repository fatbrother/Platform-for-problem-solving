import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class MyScaffold extends StatefulWidget {
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
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.secondaryColor,
      body: Column(
        children: [
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          SizedBox(
            height: Design.getScreenHeight(context) * 0.1,
            child: const MyAppBar(),
          ),
          Expanded(
            child: widget.body,
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        onTap: widget.onTap,
        currentIndex: widget.currentIndex,
      ),
    );
  }
}
