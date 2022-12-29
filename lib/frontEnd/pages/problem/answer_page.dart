import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/contract.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class AnswerPage extends StatelessWidget {
  final ProblemsModel problem;

  const AnswerPage({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      backgroundColor: Design.backgroundColor,
      body: problem.answer != ""
          ? AnswerBody(
              problem: problem,
            )
          : const HaveNotAnswerBody(),
    );
  }
}

class AnswerBody extends StatelessWidget {
  const AnswerBody({
    Key? key,
    required this.problem,
  }) : super(key: key);

  final ProblemsModel problem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: Design.spacing,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: Design.spacing,
                constraints: const BoxConstraints(
                  minHeight: 42,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Text(
                  problem.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 150,
                ),
                padding: Design.spacing,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '題目內容',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      problem.description,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 150,
                ),
                padding: Design.spacing,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '答案內容',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      problem.answer == "" ? "尚未回答" : problem.answer,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      Routes.push(context, Routes.chatRoomPage, arguments: {
                        'chatRoomId': problem.chatRoomId,
                        'canEdit': !problem.isSolved
                      });
                    },
                    backgroundColor: Design.secondaryColor,
                    child: const Icon(Icons.chat),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              problem.isSolved
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Design.getScreenWidth(context) * 0.45,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              DialogManager.showContentDialog(
                                context,
                                const Text('進入檢舉流程後便無法取消'),
                                () async {
                                  var solveCommand =
                                      await ContractsDatabase.queryContract(
                                          problem.chooseSolveCommendId);

                                  // ignore: use_build_context_synchronously
                                  Routes.push(context, Routes.reportPage,
                                      arguments: {
                                        'reporterId': problem.authorId,
                                        'beReporterId': solveCommand.solverId,
                                      });
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Design.secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Text(
                              '檢舉',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Design.getScreenWidth(context) * 0.45,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              DialogManager.showContentDialog(
                                context,
                                const Text('完成交易後便無法再提出檢舉，\n聊天室也將關閉。'),
                                () {
                                  Routes.push(
                                    context,
                                    Routes.ratingPage,
                                    arguments: problem,
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Design.secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            child: const Text(
                              '完成交易',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class HaveNotAnswerBody extends StatelessWidget {
  const HaveNotAnswerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: Design.spacing,
      child: const Center(
        child: Text(
          '尚未回答',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
