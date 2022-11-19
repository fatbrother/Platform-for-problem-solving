import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  final void Function(int) onTap;
  final int currentIndex;

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Design.insideColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/bottom_icon/home.png')),
          label: 'ViewProblem',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/bottom_icon/edit.png')),
          label: 'AddProblem',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/bottom_icon/transactionminus.png'),
            size: 35,
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/bottom_icon/bell.png')),
          label: 'notification',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/bottom_icon/asked.png')),
          label: 'asked',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/bottom_icon/user.png')),
          label: 'user',
        ),
      ],
      currentIndex: widget.currentIndex,
      selectedItemColor: Design.primaryColor,
      unselectedItemColor: Colors.black54,
      onTap: widget.onTap,
    );
  }
}
