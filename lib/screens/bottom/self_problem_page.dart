import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/other/tag.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/services/user/user.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';
import 'package:pops/widgets/buttom_navigation_bar.dart';
import 'package:pops/widgets/problem_box.dart';

class SelfProblemPage extends StatefulWidget {
  const SelfProblemPage({super.key});

  @override
  State<SelfProblemPage> createState() => _SelfProblemPageState();
}

class _SelfProblemPageState extends State<SelfProblemPage> {
  List<ProblemsModel> problems = [];
  UsersModel user = UsersModel(id: '', name: '', email: '');
  String tag = '';

  @override
  void initState() {
    super.initState();
    loadProblems();
  }

  Future<void> loadProblems() async {
    user = await AccountManager.currentUser;
    problems = [];
    if (tag == '') {
      for (var problemId in user.askProblemIds) {
        problems.add(await ProblemsDatabase.instance.query(problemId));
      }
    } else {
      for (var problemId in user.askProblemIds) {
        final problem = await ProblemsDatabase.instance.query(problemId);
        if (problem.tags.contains(tag)) {
          problems.add(problem);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      appBar: SearchBar(
        onSelected: (String text) {
          tag = text;
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
        user: user,
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
}

class ProblemHomePage extends StatelessWidget {
  final List<ProblemsModel> problems;
  final UsersModel user; 
  final void Function() onPop;

  const ProblemHomePage({
    super.key,
    required this.problems,
    required this.onPop,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var problem in problems.reversed) {
      children.add(ProbelmBoxIcon(
          problem: problem,
          onTap: () {
            if (problem.reportId != '') {
              Routes.push(context, Routes.reportWaitPage,
                  arguments: problem.reportId, onPop: onPop);
              return;
            }
            if (problem.deadline != DateTime(0) &&
                problem.isOverDeadline &&
                problem.answer == '') {
              DialogManager.showContentDialog(
                context,
                const Text('回答者超過時間未上傳答案\n代幣已全數退回'),
                () async {
                  user.tokens += problem.rewardToken;
                  user.tokens += 10;
                  var solver = await UsersDatabase.instance.query(problem.solverId);
                  solver.reportNum += 1;
                  solver.notices.add('${problem.title}超過時間未上傳答案，以被檢舉');
                  await UsersDatabase.instance.update(solver);
                  await AccountManager.updateCurrentUser(user);
                  ProblemsDatabase.instance.delete(problem.id);
                  // ignore: use_build_context_synchronously
                  Routes.pushReplacement(context, Routes.selfProblemPage);
                },
              );
              return;
            }
            if (problem.chooseSolveCommendId == '') {
              Routes.push(context, Routes.selfSingleProblemPage,
                  arguments: problem, onPop: onPop);
            } else {
              Routes.push(context, Routes.answerPage,
                  arguments: problem, onPop: onPop);
            }
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
