import 'package:flutter/material.dart';
import 'package:pops/backEnd/other/tag.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
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
  final TextEditingController _textEditingController = TextEditingController();
  String tag = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        textEditingController: _textEditingController,
        onSelected: () => setState(() {
          tag = _textEditingController.text;
        }),
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
      body: UnsolvedPageBody(tag: tag),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.unsolvedPage),
      ),
    );
  }
}

class UnsolvedPageBody extends StatefulWidget {
  final String tag;

  const UnsolvedPageBody({super.key, required this.tag});

  @override
  State<UnsolvedPageBody> createState() => _UnsolvedPageBodyState();
}

class _UnsolvedPageBodyState extends State<UnsolvedPageBody> {
  List<ProblemsModel> problems = [];

  UsersModel user = UsersModel(id: '', name: '', email: '');

  Future<void> loadProblems() async {
    user = await AccountManager.currentUser;
    if (widget.tag == '') {
      for (final id in user.commandProblemIds) {
        final problem = await ProblemsDatabase.queryProblem(id);
        problems.add(problem);
      }
    } else {
      for (final id in user.commandProblemIds) {
        final problem = await ProblemsDatabase.queryProblem(id);
        if (problem.tags.contains(widget.tag)) {
          problems.add(problem);
        }
      }
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
    List<Widget> children = [];
    for (final problem in problems) {
      children.add(
        ProbelmBoxIcon(
          problem: problem,
          onTap: () {},
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
