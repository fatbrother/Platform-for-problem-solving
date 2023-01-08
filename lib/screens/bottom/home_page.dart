import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/other/tag.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';
import 'package:pops/widgets/buttom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProblemsModel> problems = [];
  UsersModel user = UsersModel(id: '', name: '', email: '');

  @override
  void initState() {
    super.initState();
    loadProblems('');
  }

  void loadProblems(String tag) async {
    user = await AccountManager.currentUser;

    if (user.reportNum > 3) {
      AccountManager.signOut();
      if (mounted) {
        DialogManager.showInfoDialog(
          context,
          '您已被檢舉超過三次，已被停權',
          onOk: () => Routes.pushReplacement(context, Routes.login),
        );
      }
      return;
    }

    var generalProblem = (await ProblemsDatabase.instance.queryAll())
        .where((ProblemsModel problem) =>
            problem.authorId != user.id &&
            problem.isSolved == false &&
            problem.chooseSolveCommendId == '')
        .toList();
    var upVotedProblem = (await ProblemsDatabase.instance.queryAll())
        .where((ProblemsModel problem) =>
            problem.authorId != user.id &&
            problem.isSolved == false &&
            problem.isUpvoted == true &&
            problem.chooseSolveCommendId == '')
        .toList();

    if (tag == '') {
      problems = generalProblem;
    } else {
      problems = generalProblem
          .where((ProblemsModel problem) => problem.tags.contains(tag))
          .toList();
    }
    // suffle the problems
    problems.shuffle();
    upVotedProblem.shuffle();
    // add 3 upvoted problems
    for (var i = 0; i < 3 && i < upVotedProblem.length; i++) {
      if (i < upVotedProblem.length) {
        problems.insert(i, upVotedProblem[i]);
      }
    }

    setState(() {});
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
      backgroundColor: Design.backgroundColor,
      body: HomePageBody(problems: problems),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: Routes.bottomNavigationRoutes.indexOf(Routes.homePage),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  final List<ProblemsModel> problems;
  const HomePageBody({super.key, required this.problems});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var problem in problems) {
      if (problem.isSolved) {
        continue;
      }
      children.add(ProblemCard(problem: problem));
      children.add(const SizedBox(height: 10));
    }

    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(color: Design.secondaryColor),
      child: ListView(
        padding: Design.spacing,
        children: children,
      ),
    );
  }
}

class ProblemCard extends StatelessWidget {
  final ProblemsModel problem;
  const ProblemCard({
    super.key,
    required this.problem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Design.insideColor,
          borderRadius: Design.outsideBorderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Design.secondaryColor,
                borderRadius: Design.outsideBorderRadius,
              ),
              child: Center(
                child: Text(
                  problem.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                problem.description,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                  decoration: const BoxDecoration(
                    color: Design.secondaryColor,
                    borderRadius: Design.outsideBorderRadius,
                  ),
                  width: Design.getScreenWidth(context) * 0.5,
                  child: Center(
                    child: Text(
                      '底價: ${problem.baseToken}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
      onTap: () {
        Routes.push(context, Routes.questionApplyPage, arguments: problem);
      },
    );
  }
}
