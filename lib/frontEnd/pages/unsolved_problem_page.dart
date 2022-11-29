import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/backEnd/user/account.dart';

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
      home: const UnsolvedPage(/*title: 'Flutter Demo Home Page'*/),
    );
  }
}

class UnsolvedPage extends StatefulWidget {
  const UnsolvedPage({
    super.key,
    /*required this.title*/
  });

  //final String title;

  @override
  State<UnsolvedPage> createState() => _UnsolvedPageState();
}

class _UnsolvedPageState extends State<UnsolvedPage> {
  final controller = ScrollController();
  List<ProblemsModel> allProblems = [];
  UsersModel user = UsersModel(id: '', email: '', name: '');

  ////bool hasMore = true;
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //print('Initiate call');

    loadProblems();
    //print(allProblems.length);

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        loadProblems();
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
    loadUserInfo();
    loadProblems();
    //print(allProblems.length);
    return Scaffold(
        appBar: AppBar(
            title: const Text('Infinite Scroll ListView'),
            backgroundColor: Colors.blue),
        body: //RefreshIndicator(
            //onRefresh: refresh,
            /*child:*/ ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount: allProblems.length + 1,
                itemBuilder: (context, index) {
                  print("length: ${allProblems.length}");
                  //if (index < allProblems.length) {
                  //if (index < 5) {
                  if (index < allProblems.length) {
                    print(index);
                    print("in if 1\n");
                    print(
                        "problem solver: ${allProblems[index].chooseSolveCommendId}");
                    print("user id: ${user.id}");
                    //if (allProblems[index].chooseSolveCommendId == user.id &&
                    //    !allProblems[index].isSolved) {
                    //final item = allProblems[index];
                    print(index);
                    print('in if 2\n');
                    return ListTile(
                        title: Text(allProblems[index].chooseSolveCommendId));
                    //}
                    //return Container();
                  } //else {
                  //var listOfContainers = <Container>[];
                  //allProblems.forEach((element) {
                  //  return listOfContainers
                  //      .add(Container(child: Text(allProblems[index].title)));
                  //});
                  //if (index < allProblems.length) {
                  //  final item = allProblems[index];
                  //  //print('in if\n');
                  //  //print(index);
                  //  return ListTile(title: Text(item.title));
                  //}
                  /*return Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: /*hasMore
                    ? const CircularProgressIndicator()
                   : const Text('No more data to load'),*/
                      Text('CatCat'),
                ),
              );*/
                  return Container();
                }
                //},
                )
        //)
        );
  }

  Future<void> loadProblems() async {
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
        solveCommendIds: ["fY6Q7kpoTTTMQ6QQw1Rk6fLJkew1"],
        chooseSolveCommendId: "fY6Q7kpoTTTMQ6QQw1Rk6fLJkew1",
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
        solveCommendIds: ["sdfjns"],
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
        solveCommendIds: ["fY6Q7kpoTTTMQ6QQw1Rk6fLJkew1"],
        chooseSolveCommendId: "fY6Q7kpoTTTMQ6QQw1Rk6fLJkew1",
        createdAt: DateTime(2022, 09, 17),
        remainingDays: 15,
        rewardToken: 100);
    ProblemsDatabase.addProblem(problem3);

    if (isLoading) return;
    isLoading = true;

    allProblems = await ProblemsDatabase.queryAllProblems();

    setState(() {});
  }

  Future<void> loadUserInfo() async {
    user = await AccountManager.currentUser;
    setState(() {
      user = user;
    });
  }
}
