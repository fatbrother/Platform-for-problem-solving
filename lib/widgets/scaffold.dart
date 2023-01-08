import 'package:flutter/material.dart';
import 'package:pops/widgets/app_bar.dart';
import 'package:pops/widgets/buttom_navigation_bar.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    super.key,
    required this.body,
    required this.backgroundColor,
    required this.currentIndex,
  });

  final int currentIndex;
  final Color backgroundColor;
  final Widget body;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GoBackBar(),
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

