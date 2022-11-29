import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

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
  List<ProblemsModel> problems = [];

  @override
  void initState() {
    super.initState();
    loadProblems();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var problem in problems) {
      children.add(ProbelmBoxIcon(problem: problem));
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

class ProbelmBoxIcon extends StatelessWidget {
  final ProblemsModel problem;

  const ProbelmBoxIcon({
    super.key,
    required this.problem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 3.0,
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: const BoxDecoration(
                      borderRadius: Design.outsideBorderRadius,
                      color: Design.secondaryColor,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        problem.title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            right: 15, left: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const ImageIcon(
                              AssetImage('assets/icon/users.png'),
                              color: Colors.black,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              problem.authorName,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.access_time_rounded),
                            const SizedBox(width: 10),
                            Text(
                              problem.existTimeString,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}
