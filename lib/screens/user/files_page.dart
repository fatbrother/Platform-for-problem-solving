import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';
import 'package:pops/widgets/problem_box.dart';

class FilesPage extends StatefulWidget {
  final FolderModel folder;

  const FilesPage({super.key, required this.folder});

  @override
  State<FilesPage> createState() => _FilesPage();
}

class _FilesPage extends State<FilesPage> {
  bool _isSnackBarActive = false;

  UsersModel user = UsersModel(id: '', name: '', email: '');
  List<ProblemsModel> problemInFolder = [];
  List<ProblemsModel> problems = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (final problem in problemInFolder) {
      children.add(
        ProbelmBoxIcon(
          problem: problem,
          onTap: () {
            if (problem.reportId != '') {
              Routes.push(context, Routes.reportWaitPage,
                  arguments: problem.reportId);
              return;
            }
            if (problem.deadline != DateTime(0) &&
                problem.isOverDeadline &&
                problem.answer == '') {
              DialogManager.showContentDialog(
                context,
                const Text('回答者超過時間未上傳答案\n代幣以全數退回\n回答者的保證金以加入錢包'),
                () {
                  user.tokens += problem.rewardToken;
                  user.tokens += 10;
                  AccountManager.updateCurrentUser(user);
                  ProblemsDatabase.instance.delete(problem.id);
                  Routes.pushReplacement(context, Routes.selfProblemPage);
                },
              );
              return;
            }
            if (problem.chooseSolveCommendId == '') {
              Routes.push(context, Routes.selfSingleProblemPage,
                  arguments: problem);
            } else {
              Routes.push(context, Routes.answerPage, arguments: problem);
            }
          },
          onLongPress: () {
            DialogManager.showContentDialog(
                context, Text('確定從資料夾中移除${problem.title}?'), () {
              widget.folder.problemIds.remove(problem.id);
              for (final folder in user.folders) {
                if (folder.name == widget.folder.name) {
                  folder.problemIds = widget.folder.problemIds;
                  break;
                }
              }
              AccountManager.updateCurrentUser(user);
              problemInFolder.remove(problem);
              problems.add(problem);
              setState(() {});
            });
          },
        ),
      );
      children.add(const SizedBox(height: 10));
    }

    return WillPopScope(
      child: Scaffold(
        appBar: GoBackBar(onPop: () {
          if (_isSnackBarActive) {
            closeSnackBar();
          }
        }),
        backgroundColor: Design.secondaryColor,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: Design.spacing,
                children: children,
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
      ),
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
    );
  }

  void closeSnackBar() {
    setState(() {
      _isSnackBarActive = false;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  Future<void> loadInfo() async {
    user = await AccountManager.currentUser;
    problemInFolder.clear();
    problems.clear();
    for (final id in user.askProblemIds) {
      // check if id in widget.folder.problemIds
      if (widget.folder.problemIds.contains(id)) {
        problemInFolder.add(await ProblemsDatabase.instance.query(id));
      } else {
        problems.add(await ProblemsDatabase.instance.query(id));
      }
    }
    setState(() {});
  }

  void showSnackBar() {
    setState(() {
      _isSnackBarActive = true;
    });
    List<Widget> children = [];
    for (final problem in problems) {
      children.add(ProbelmBoxIcon(
        problem: problem,
        onTap: () async {
          widget.folder.problemIds.add(problem.id);
          user.folders = user.folders
              .map((e) => e.name == widget.folder.name ? widget.folder : e)
              .toList();
          await AccountManager.updateCurrentUser(user);
          loadInfo();
          closeSnackBar();
        },
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
