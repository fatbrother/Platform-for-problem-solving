import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/services/other/tag.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';
import 'package:pops/widgets/buttom_navigation_bar.dart';
import 'package:pops/widgets/problem_box.dart';

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
        final problem = await ProblemsDatabase.instance.query(id);
        problems.add(problem);
      }
    } else {
      for (final id in user.commandProblemIds) {
        final problem = await ProblemsDatabase.instance.query(id);
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
      if (problem.isSolved) {
        continue;
      }
      children.add(
        ProbelmBoxIcon(
          problem: problem,
          onTap: () {
            if (problem.chatRoomId != '') {
              Routes.push(context, Routes.chatRoomPage, arguments: {
                'chatRoomId': problem.chatRoomId,
                'canEdit': true
              });
            } else {
              Routes.push(context, Routes.uploadAnsPage, arguments: problem);
            }
          },
        ),
      );
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
