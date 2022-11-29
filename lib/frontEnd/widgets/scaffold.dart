import 'package:flutter/material.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({
    super.key,
    required this.body,
    required this.backgroundColor,
    required this.currentIndex,
  });

  final int currentIndex;
  final Color backgroundColor;
  final Widget body;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      backgroundColor: widget.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: widget.body,
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: widget.currentIndex,
      ),
    );
  }
}
