import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(),
      backgroundColor: Design.backgroundColor,
      body: const HomePageBody(),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: Routes.bottomNavigationRoutes.indexOf(Routes.homePage),
      ),
    );
  }
}

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  List<ProblemsModel> problems = [];

  @override
  void initState() {
    super.initState();
    loadProblems();
  }

  void loadProblems() async {
    problems = await ProblemsDatabase.queryAllProblems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var problem in problems) {
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
                maxLines: 3,
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
