import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pops/backEnd/problem/problem.dart';

//void main() {
//  runApp(const MyApp());
//}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(/*title: 'Flutter Demo Home Page'*/),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    /*required this.title*/
  });

  //final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  List<ProblemsModel> allProblems = [];
  ////bool hasMore = true;
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //print('Initiate call');

    loadUnsolvedQ();
    //print(allProblems.length);

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        loadUnsolvedQ();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  ////Future refresh() async{
  ////  setState((){
  ////    isLoading = false;
  ////    hasMore = true;
  ////    page = 0;
  ////    items.clear();
  ////  });

  ////  fetch();
  ////}

  @override
  Widget build(BuildContext context) {
    loadUnsolvedQ();
    //print(allProblems.length);
    return Scaffold(
        appBar: AppBar(title: const Text('Infinite Scroll ListView')),
        body: //RefreshIndicator(
            //onRefresh: refresh,
            /*child:*/ ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount: allProblems.length + 1,
                itemBuilder: (context, index) {
                  //print(allProblems.length);
                  if (index < allProblems.length) {
                    final item = allProblems[index];

                    return ListTile(title: Text(item.id));
                  } //else {
                  var listOfContainers = <Container>[];
                  allProblems.forEach((element) {
                    return listOfContainers
                        .add(Container(child: Text(allProblems[index].title)));
                  });
                  /*return Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: /*hasMore
                    ? const CircularProgressIndicator()
                   : const Text('No more data to load'),*/
                      Text('CatCat'),
                ),
              );*/
                  return Container(
                    child: Text('CatCat'),
                  );
                }
                //},
                )
        //)
        );
  }

  Future<void> loadUnsolvedQ() async {
    //print("Load");
    ProblemsModel problem1 = ProblemsModel(
        id: "01",
        title: "Q1 title",
        description: "kjsdhlfsjdbanjehfiuesrhvmdnvmjhfjsmd\nksjdnsdcm,mxncksjd",
        authorName: "CatCat",
        authorId: "1019",
        imgIds: ["0"],
        tags: ["Good"],
        isSolved: false,
        baseToken: 0,
        solveCommendIds: ["abc"],
        chooseSolveCommendId: "sdfjns",
        createdAt: DateTime(2022, 09, 17),
        remainingDays: 15,
        rewardToken: 100);
    ProblemsDatabase.addProblem(problem1);

    ProblemsModel problem2 = ProblemsModel(
        id: "02",
        title: "Q2 title",
        description: "kjsdhlfsjdbanjehfiuesrhvmdnvmjhfjsmd\nksjdnsdcm,mxncksjd",
        authorName: "CatCat",
        authorId: "1019",
        imgIds: ["0"],
        tags: ["Good"],
        isSolved: false,
        baseToken: 0,
        solveCommendIds: ["abc"],
        chooseSolveCommendId: "sdfjns",
        createdAt: DateTime(2022, 09, 17),
        remainingDays: 15,
        rewardToken: 100);
    ProblemsDatabase.addProblem(problem2);

    ProblemsModel problem3 = ProblemsModel(
        id: "03",
        title: "Q3 title",
        description: "kjsdhlfsjdbanjehfiuesrhvmdnvmjhfjsmd\nksjdnsdcm,mxncksjd",
        authorName: "CatCat",
        authorId: "1019",
        imgIds: ["0"],
        tags: ["Good"],
        isSolved: false,
        baseToken: 0,
        solveCommendIds: ["abc"],
        chooseSolveCommendId: "sdfjns",
        createdAt: DateTime(2022, 09, 17),
        remainingDays: 15,
        rewardToken: 100);
    ProblemsDatabase.addProblem(problem3);

    if (isLoading) return;
    isLoading = true;

    allProblems = await ProblemsDatabase.queryAllProblems();

    setState(() {});
  }
}
