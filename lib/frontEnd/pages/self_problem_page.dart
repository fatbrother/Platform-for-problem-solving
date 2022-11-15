import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';

class SelfProblemPage extends StatefulWidget {
  const SelfProblemPage({super.key});

  @override
  State<SelfProblemPage> createState() => _SelfProblemPageState();
}

class _SelfProblemPageState extends State<SelfProblemPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color.fromRGBO(217, 217, 217, 10),
          title: Container(
            padding:
                const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 0),
            margin: const EdgeInsets.all(0),
            //height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: SizedBox(
              //  height: 20,
              child: TextField(
                controller: _textEditingController,
                style: const TextStyle(
                  fontSize: 25,
                  height: 1.5,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffix: IconButton(
                      onPressed: _textEditingController.clear,
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.black,
                      )),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          )),
      //   backgroundColor: Color.fromRGBO(200, 217, 217, 100),
      body: const ProblemHomePage(),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: 0,
          onTap: (int idx) {},
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 24,
                ),
                label: '1'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.accessibility,
                  color: Colors.black,
                  size: 24,
                ),
                label: '2'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.accessibility,
                  color: Colors.black,
                  size: 24,
                ),
                label: '3'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.access_time,
                  color: Colors.black,
                  size: 24,
                ),
                label: '4'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.abc_rounded,
                  color: Colors.black,
                  size: 24,
                ),
                label: '5'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.ac_unit_outlined,
                  color: Colors.black,
                  size: 24,
                ),
                label: '6'),
          ],
        ),
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
  Widget build(BuildContext context) {
    loadProblems();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Design.secondaryColor,
      ),
      child: ListView(
        children: problems
            .map((e) => ProbelmBoxIcon(
                problem: e,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                      Routes.selfSingleProblemPage,
                      arguments: e);
                }))
            .toList(),
      ),
    );
  }

  void loadProblems() async {
    problems = await ProblemsDatabase.queryAllProblems();
    setState(() {});
  }
}

class ProbelmBoxIcon extends StatelessWidget {
  final ProblemsModel problem;
  final void Function() onPressed;

  const ProbelmBoxIcon({
    super.key,
    required this.onPressed,
    required this.problem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.only(
                left: 10.0, right: 10.0, top: 5, bottom: 5),
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
                      vertical: 5.0,
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color.fromRGBO(79, 128, 155, 100),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        problem.title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            right: 15, left: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.accessibility_new_rounded),
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
                            Text(
                              problem.existTimeString,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.abc),
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
