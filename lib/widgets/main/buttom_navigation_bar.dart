import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final void Function(int) onTap;

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
          label: 'add',
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
      currentIndex: currentIndex,
      selectedItemColor: Design.primaryColor,
      unselectedItemColor: Colors.black54,
      onTap: onTap,
    );
  }
}
