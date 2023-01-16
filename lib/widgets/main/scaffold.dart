import 'package:flutter/material.dart';
import 'package:pops/widgets/main/app_bar.dart';

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const GoBackBar(),
        backgroundColor: widget.backgroundColor,
        body: Column(
          children: [
            Expanded(
              child: widget.body,
            ),
          ],
        ),
      ),
    );
  }
}

