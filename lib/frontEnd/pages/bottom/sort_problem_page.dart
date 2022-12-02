import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class SortProblemPage extends StatelessWidget {
  const SortProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
      backgroundColor: Design.secondaryColor,
      body: const SortProblemPageBody(),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.sortProblemPage),
      ),
    );
  }
}

class SortProblemPageBody extends StatefulWidget {
  const SortProblemPageBody({super.key});

  @override
  State<SortProblemPageBody> createState() => _SortProblemPageBodyState();
}

class _SortProblemPageBodyState extends State<SortProblemPageBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}