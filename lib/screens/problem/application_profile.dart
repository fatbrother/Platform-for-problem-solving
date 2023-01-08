import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/screens/bottom/self_information_page.dart';
import 'package:pops/services/problem/contract.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/services/user/account.dart';
import 'package:pops/services/user/user.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';

class ApplicationProfilePage extends StatefulWidget {
  final UsersModel solver;
  final ContractsModel contract;
  final ProblemsModel problem;

  const ApplicationProfilePage({
    super.key,
    required this.solver,
    required this.contract,
    required this.problem,
  });

  @override
  State<ApplicationProfilePage> createState() => _ApplicationProfilePageState();
}

class _ApplicationProfilePageState extends State<ApplicationProfilePage> {
  UsersModel currentUser = UsersModel(id: '', name: '', email: '');

  Future<void> loadCurrentUser() async {
    currentUser = await AccountManager.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const GoBackBar(),
        backgroundColor: Design.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                margin: Design.spacing,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Design.secondaryColor,
                ),
                height: 500,
                child: ListView(
                  padding: Design.spacing,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Design.insideColor,
                        radius: Design.getScreenWidth(context) / 5,
                        foregroundImage:
                            Image.asset('assets/icon/defultUserIcon.png').image,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 40,
                      padding: Design.spacing,
                      decoration: BoxDecoration(
                          color: Design.insideColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(widget.solver.name,
                            style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ScoreBar(user: widget.solver),
                    const SizedBox(height: 10),
                    SelfTagBar(user: widget.solver),
                    const SizedBox(height: 10),
                    Container(
                      padding: Design.spacing,
                      decoration: const BoxDecoration(
                        color: Design.insideColor,
                        borderRadius: Design.outsideBorderRadius,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text("自我介紹", style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 10),
                          Text(
                            widget.solver.selfIntroduction == ""
                                ? "尚未填寫"
                                : widget.solver.selfIntroduction,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: Design.spacing,
                      decoration: BoxDecoration(
                          color: Design.insideColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('部分答案', style: TextStyle(fontSize: 20)),
                          const SizedBox(height: 10),
                          Text(
                            widget.contract.partialAns,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: Design.spacing,
                      decoration: const BoxDecoration(
                          color: Design.insideColor,
                          borderRadius: Design.outsideBorderRadius),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.attach_money_rounded),
                          Text(widget.contract.price.toString(),
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: Design.spacing,
              child: ElevatedButton(
                onPressed: () => DialogManager.showContentDialog(
                    context,
                    Text(
                        '選擇後將收取差額${widget.contract.price - widget.problem.baseToken}代幣。'),
                    () {
                  if (widget.contract.price - widget.problem.baseToken >
                      currentUser.tokens) {
                    DialogManager.showContentDialog(
                        context, const Text('代幣不足，請先儲值。'), () {
                      Routes.push(context, Routes.topUpPage);
                    });
                  } else {
                    chooseSolver();
                    DialogManager.showInfoDialog(context, '扣款成功!',
                        onOk: () => Routes.pushReplacement(context, Routes.homePage));
                  }
                }),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Design.secondaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: Design.outsideBorderRadius)),
                child: const Text(
                  '確認選擇',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ),
          ],
        ));
  }

  Future<void> chooseSolver() async {
    widget.problem.chooseSolveCommendId = widget.contract.id;
    for (final contractId in widget.problem.solveCommendIds) {
      if (contractId != widget.contract.id) {
        ContractsDatabase.deleteContract(contractId);
      }
    }
    widget.problem.solveCommendIds = [];
    widget.problem.rewardToken = widget.contract.price;
    widget.problem.solverId = widget.solver.id;
    widget.problem.solverName = widget.solver.name;
    widget.problem.deadline = widget.contract.deadline;
    ProblemsDatabase.updateProblem(widget.problem);
    widget.solver.commandProblemIds.add(widget.problem.id); 
    widget.solver.notices.add(
        '應徵成功！請於${widget.contract.deadline.toLocal().toString()}前上傳「${widget.problem.title}」的答案。');
    await UsersDatabase.instance.update(widget.solver);
    currentUser = await AccountManager.currentUser;
    currentUser.tokens -= widget.contract.price - widget.problem.baseToken;
    AccountManager.updateCurrentUser(currentUser);
  }
}
