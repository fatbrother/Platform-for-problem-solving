import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/services/problem/contract.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';

class AnswerPage extends StatelessWidget {
  final ProblemsModel problem;

  const AnswerPage({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GoBackBar(),
      backgroundColor: Design.backgroundColor,
      body: problem.answer != ""
          ? AnswerBody(problem: problem)
          : const HaveNotAnswerBody(),
    );
  }
}

class AnswerBody extends StatefulWidget {
  const AnswerBody({
    Key? key,
    required this.problem,
  }) : super(key: key);

  final ProblemsModel problem;

  @override
  State<AnswerBody> createState() => _AnswerBodyState();
}

class _AnswerBodyState extends State<AnswerBody> {
  List<Image> images = [];

  void loadImages() async {
    for (final id in widget.problem.imgIds) {
      images.add(Image.network(
        await ImgManager.getImageUrl(id),
        width: double.infinity,
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadImages();
  }

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
                  widget.problem.title,
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
                      widget.problem.description,
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
                      widget.problem.answer,
                      style: const TextStyle(fontSize: 18),
                    ),
                    for (var img in images) img,
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
                        'chatRoomId': widget.problem.chatRoomId,
                        'canEdit': !widget.problem.isSolved
                      });
                    },
                    backgroundColor: Design.secondaryColor,
                    child: const Icon(Icons.chat),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              widget.problem.isSolved
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
                                      await ContractsDatabase.instance.query(
                                          widget.problem.chooseSolveCommendId);

                                  // ignore: use_build_context_synchronously
                                  Routes.push(context, Routes.reportPage,
                                      arguments: {
                                        'problem': widget.problem,
                                        'reporterId': widget.problem.authorId,
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
                                    arguments: widget.problem,
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
