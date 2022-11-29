import 'package:flutter/material.dart';
import 'package:pops/backEnd/other/tag.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: Design.getScreenHeight(context) * 0.06),
          const SearchBar(),
          const HomePageBody(),
        ],
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: Routes.bottomNavigationRoutes.indexOf(Routes.homePage),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<String> autofillHints = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Design.backgroundColor,
        ),
        child: Container(
          height: Design.getScreenHeight(context) * 0.05,
          width: Design.getScreenWidth(context) * 0.9,
          decoration: BoxDecoration(
            color: Design.insideColor,
            borderRadius:
                BorderRadius.circular(Design.getScreenHeight(context) * 0.05),
          ),
          child: AutofillGroup(
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.search),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                    onChanged: onChanged,
                    autofillHints: autofillHints,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onChanged(String value) async {
    for (var item in await TagsDatabase.querySimilarTags(value)) {
      autofillHints.add(item);
      debugPrint(item);
    }

    setState(() {});
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

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(color: Design.secondaryColor),
        child: ListView(
          padding: Design.spacing,
          children: children,
        ),
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
                  width: Design.getScreenWidth(context) * 0.4,
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
        // Routes.push(context, Routes.problemPage, arguments: problem);
      },
    );
  }
}
