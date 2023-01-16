import 'package:flutter/material.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/main/buttom_navigation_bar.dart';

class BaseMainPage extends StatefulWidget {
  const BaseMainPage({super.key});

  @override
  State<BaseMainPage> createState() => _BaseMainPageState();
}

class _BaseMainPageState extends State<BaseMainPage> {
  int nowIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Routes.routes[Routes.bottomNavigationRoutes[nowIndex]]!(context),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: nowIndex,
        onTap: (index) => setState(() => nowIndex = index),
      ),
    );
  }
}
