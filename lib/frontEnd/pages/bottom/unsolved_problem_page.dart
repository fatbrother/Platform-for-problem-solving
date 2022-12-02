import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class UnsolvedPage extends StatelessWidget {
  const UnsolvedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
      backgroundColor: Design.secondaryColor,
      body: const UnsolvedPageBody(),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.unsolvedPage),
      ),
    );
  }
}

class UnsolvedPageBody extends StatefulWidget {
  const UnsolvedPageBody({super.key});

  @override
  State<UnsolvedPageBody> createState() => _UnsolvedPageBodyState();
}

class _UnsolvedPageBodyState extends State<UnsolvedPageBody> {
  List<ProblemsModel> problems = [];
  UsersModel user = UsersModel(id: '', name: '', email: '');

  Future<void> loadProblems() async {
    user = await AccountManager.currentUser;
    for (final id in user.commandProblemIds) {
      final problem = await ProblemsDatabase.queryProblem(id);
      problems.add(problem);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadProblems();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [],
    );
  }
}

