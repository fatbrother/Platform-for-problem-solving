import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/contract.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/tag.dart';

class SelfSinglefProblemPage extends StatefulWidget {
  final ProblemsModel problem;

  const SelfSinglefProblemPage({super.key, required this.problem});
  @override
  State<StatefulWidget> createState() => _SelfSinglefProblemPage();
}

class _SelfSinglefProblemPage extends State<SelfSinglefProblemPage> {
  List<ContractsModel> contracts = [];

  Future<void> loadApplications() async {
    for (final id in widget.problem.solveCommendIds) {
      contracts.add(await ContractsDatabase.queryContract(id));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SimpleAppBar(),
        backgroundColor: Design.backgroundColor,
        body: SingleProblemPageBody(
          contracts: contracts,
          problem: widget.problem,
        ));
  }
}

class SingleProblemPageBody extends StatefulWidget {
  const SingleProblemPageBody({
    Key? key,
    required this.contracts,
    required this.problem,
  }) : super(key: key);

  final List<ContractsModel> contracts;
  final ProblemsModel problem;

  @override
  State<SingleProblemPageBody> createState() => _SingleProblemPageBodyState();
}

class _SingleProblemPageBodyState extends State<SingleProblemPageBody> {
  UsersModel user = UsersModel(id: '', name: '', email: '');

  Future<void> loadUser() async {
    user = await AccountManager.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (final contract in widget.contracts) {
      children.add(ApplicationBox(contract: contract, problem: widget.problem));
    }

    return Container(
      height: double.infinity,
      margin: Design.spacing,
      decoration: const BoxDecoration(
          color: Design.secondaryColor,
          borderRadius: Design.outsideBorderRadius),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: ListView(padding: Design.spacing, children: children)),
          Container(
            height: 40,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      DialogManager.showContentDialog(
                        context,
                        const Text('刪除後不會歸還上架金額！'),
                        () {
                          user.tokens += widget.problem.baseToken;
                          user.askProblemIds.remove(widget.problem.id);
                          AccountManager.updateCurrentUser(user);
                          ProblemsDatabase.deleteProblem(widget.problem.id);
                          Routes.back(context);
                        },
                      );
                    },
                    icon: const Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      if (widget.problem.isUpvoted) {
                        DialogManager.showInfoDialog(context, '已經加價過了');
                        return;
                      }
                      DialogManager.showContentDialog(
                        context,
                        const Text('加價15代幣以增加平台推廣'),
                        () {
                          user.tokens -= 15;
                          AccountManager.updateCurrentUser(user);
                          widget.problem.isUpvoted = true;
                          ProblemsDatabase.updateProblem(widget.problem);
                        },
                      );
                    },
                    icon: const Icon(Icons.monetization_on_outlined)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ApplicationBox extends StatefulWidget {
  final ContractsModel contract;
  final ProblemsModel problem;

  const ApplicationBox({
    super.key,
    required this.contract,
    required this.problem,
  });

  @override
  State<ApplicationBox> createState() => _ApplicationBoxState();
}

class _ApplicationBoxState extends State<ApplicationBox> {
  UsersModel user = UsersModel(id: '', name: '', email: '');

  Future<void> loadUser() async {
    user = await UsersDatabase.queryUser(widget.contract.solverId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            Routes.push(context, Routes.applicationProfilePage, arguments: {
              'user': user,
              'contract': widget.contract,
              'problem': widget.problem,
            });
          },
          child: Container(
            padding: Design.spacing,
            decoration: const BoxDecoration(
              borderRadius: Design.outsideBorderRadius,
              color: Design.insideColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    borderRadius: Design.outsideBorderRadius,
                    color: Design.secondaryColor,
                  ),
                  child: Text(
                    user.name,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.attach_money),
                    Text(widget.contract.price.toString()),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    const Icon(Icons.discount_outlined),
                    for (final tag in user.displaySystemTags)
                      ShowTagsWidget(title: tag, isGeneral: false),
                    for (final tag in user.expertiseTags)
                      ShowTagsWidget(title: tag, isGeneral: true),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
