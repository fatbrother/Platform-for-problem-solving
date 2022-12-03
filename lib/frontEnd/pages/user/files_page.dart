import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/problem_box.dart';

class FolderPage extends StatefulWidget {
  final FolderModel folder;

  const FolderPage({super.key, required this.folder});

  @override
  State<FolderPage> createState() => _FolderPage();
}

class _FolderPage extends State<FolderPage> {
  bool _isSnackBarActive = false;

  UsersModel user = UsersModel(id: '', name: '', email: '');
  List<ProblemsModel> problemInFolder = [];
  List<ProblemsModel> problems = [];


  Future<void> loadInfo() async {
    user = await AccountManager.currentUser;
    for (final id in user.askProblemIds) {
      // check if id in  widget.folder.problemIds
      if (widget.folder.problemIds.contains(id)) {
        problemInFolder.add(await ProblemsDatabase.queryProblem(id));
      }
      else {
        problems.add(await ProblemsDatabase.queryProblem(id));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (final problem in problemInFolder) {
      children.add(ProbelmBoxIcon(
        problem: problem,
        onTap: () {},
      ));
      children.add(const SizedBox(height: 10));
    }

    return Scaffold(
      appBar: const SimpleAppBar(),
      backgroundColor: Design.secondaryColor,
      body: Column(
        children: [
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView(
                padding: Design.spacing,
                children: children,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isSnackBarActive ? closeSnackBar : showSnackBar,
        backgroundColor: Design.primaryColor,
        child: const ImageIcon(
          AssetImage('assets/icon/fileAdd.png'),
          color: Colors.black,
        ),
      ),
    );
  }

  void closeSnackBar() {
    setState(() {
      _isSnackBarActive = false;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  void showSnackBar() {
    setState(() {
      _isSnackBarActive = true;
    });
    List<Widget> children = [];
    for (final problem in problems) {
      children.add(ProbelmBoxIcon(
        problem: problem,
        onTap: () {},
        isColorReversed: true,
      ));
      children.add(const SizedBox(height: 10));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      // create a list of problems user can choose from
      SnackBar(
        padding: const EdgeInsets.all(0),
        duration: const Duration(minutes: 60),
        backgroundColor: Design.insideColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        content: SizedBox(
          height: Design.getScreenHeight(context) * 0.5,
          child: ListView(
            padding: Design.spacing,
            children: children,
          ),
        ),
      ),
    );
  }
}
