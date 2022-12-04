import 'package:flutter/material.dart';
import 'package:pops/backEnd/other/tag.dart';
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
  List<ProblemsModel> problems = [];
  final TextEditingController _textEditingController = TextEditingController();
  String tag = '';

  @override
  void initState() {
    super.initState();
    loadProblems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      appBar: SearchBar(
        textEditingController: _textEditingController,
        onSelected: () {
          tag = _textEditingController.text;
          loadProblems();
        },
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
      body: ProblemHomePage(
        problems: problems,
        onPop: () {
          Future.delayed(const Duration(seconds: 1), () {
            loadProblems();
          });
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.selfProblemPage),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Routes.push(context, Routes.addProblemPage, onPop: () {
          Future.delayed(const Duration(seconds: 1), () {
            loadProblems();
          });
        }),
        backgroundColor: Design.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> loadProblems() async {
    final user = await AccountManager.currentUser;
    problems = [];
    if (tag == '') {
      for (var problemId in user.askProblemIds) {
        problems.add(await ProblemsDatabase.queryProblem(problemId));
      }
    } else {
      for (var problemId in user.askProblemIds) {
        final problem = await ProblemsDatabase.queryProblem(problemId);
        if (problem.tags.contains(tag)) {
          problems.add(problem);
        }
      }
    }
    setState(() {});
  }
}

class ProblemHomePage extends StatefulWidget {
  final List<ProblemsModel> problems;
  final void Function() onPop;

  const ProblemHomePage(
      {super.key, required this.problems, required this.onPop});

  @override
  ProblemHomePageState createState() => ProblemHomePageState();
}

class ProblemHomePageState extends State<ProblemHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var problem in widget.problems) {
      children.add(ProbelmBoxIcon(
          problem: problem,
          onTap: () {
            Routes.push(context, Routes.selfSingleProblemPage,
                arguments: problem, onPop: widget.onPop);
          }));
      children.add(const SizedBox(height: 10));
    }

    return Container(
      decoration: const BoxDecoration(
        color: Design.secondaryColor,
      ),
      child: ListView(
        padding: Design.spacing,
        children: children,
      ),
    );
  }
}
