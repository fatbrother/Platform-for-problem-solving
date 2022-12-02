import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';
import 'package:pops/frontEnd/widgets/problem_box.dart';

class SelfProblemPage extends StatefulWidget {
  const SelfProblemPage({super.key});

  @override
  State<SelfProblemPage> createState() => _SelfProblemPageState();
}

class _SelfProblemPageState extends State<SelfProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      appBar: SearchBar(),
      body: const ProblemHomePage(),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.selfProblemPage),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Routes.push(context, Routes.addProblemPage),
        backgroundColor: Design.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ProblemHomePage extends StatefulWidget {
  const ProblemHomePage({super.key});

  @override
  ProblemHomePageState createState() => ProblemHomePageState();
}

class ProblemHomePageState extends State<ProblemHomePage> {
  List<ProblemsModel> problems = [
    ProblemsModel(
      id: '1',
      title: 'Problem 1',
      description: 'Description 1',
      tags: ['tag1', 'tag2'],
      authorId: '1',
      authorName: 'Author 1',
      createdAt: DateTime.now(),
    ),
    ProblemsModel(
      id: '2',
      title: 'Problem 2',
      description: 'Description 2',
      tags: ['tag1', 'tag2'],
      authorId: '1',
      authorName: 'Author 1',
      createdAt: DateTime.now(),
    ),
    ProblemsModel(
      id: '3',
      title: 'Problem 3',
      description: 'Description 3',
      tags: ['tag1', 'tag2'],
      authorId: '1',
      authorName: 'Author 1',
      createdAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    loadProblems();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var problem in problems) {
      children.add(ProbelmBoxIcon(problem: problem, onTap: () {}));
      children.add(const SizedBox(height: 10));
    }

    return Container(
      padding: Design.spacing,
      decoration: const BoxDecoration(
        color: Design.secondaryColor,
      ),
      child: ListView(
        children: children,
      ),
    );
  }

  void loadProblems() async {
    final user = await AccountManager.currentUser;
    for (var problemId in user.askProblemIds) {
      problems.add(await ProblemsDatabase.queryProblem(problemId));
    }
    setState(() {});
  }
}
