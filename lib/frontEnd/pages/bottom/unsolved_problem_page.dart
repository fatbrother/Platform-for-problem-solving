import 'package:flutter/material.dart';
import 'package:pops/backEnd/other/tag.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';
import 'package:pops/frontEnd/widgets/problem_box.dart';

class UnsolvedPage extends StatefulWidget {
  const UnsolvedPage({super.key});

  @override
  State<UnsolvedPage> createState() => _UnsolvedPageState();
}

class _UnsolvedPageState extends State<UnsolvedPage> {
  List<ProblemsModel> problems = [];

  Future<void> loadProblems(String tag) async {
    var user = await AccountManager.currentUser;
    if (tag == '') {
      for (final id in user.commandProblemIds) {
        final problem = await ProblemsDatabase.queryProblem(id);
        problems.add(problem);
      }
    } else {
      for (final id in user.commandProblemIds) {
        final problem = await ProblemsDatabase.queryProblem(id);
        if (problem.tags.contains(tag)) {
          problems.add(problem);
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadProblems('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        onSelected: loadProblems,
        getSuggestions: (String text) {
          if (text == '') {
            return [];
          } else {
            return TagsDatabase.querySimilarTags(text)
                .map((e) => e.name)
                .toList();
          }
        },
      ),
      backgroundColor: Design.secondaryColor,
      body: UnsolvedPageBody(problems: problems),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.unsolvedPage),
      ),
    );
  }
}

class UnsolvedPageBody extends StatelessWidget {
  final List<ProblemsModel> problems;
  
  const UnsolvedPageBody({super.key, required this.problems});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (final problem in problems) {
      children.add(
        ProbelmBoxIcon(
          problem: problem,
          onTap: () {
            Routes.push(context, Routes.uploadAnsPage, arguments: problem);
          },
        ),
      );
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
}
