import 'package:flutter/material.dart';
import 'package:pops/backEnd/other/chat_room.dart';
import 'package:pops/backEnd/other/img.dart';
import 'package:pops/backEnd/problem/contract.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class UploadAnsPage extends StatefulWidget {
  final ProblemsModel problem;

  const UploadAnsPage({super.key, required this.problem});

  @override
  State<UploadAnsPage> createState() => _UploadAnsPageState();
}

class _UploadAnsPageState extends State<UploadAnsPage> {
  ContractsModel contract = ContractsModel();
  List<Image> images = [];

  Future<void> loadContracts() async {
    contract = await ContractsDatabase.queryContract(
        widget.problem.chooseSolveCommendId);
    setState(() {});
  }

  void loadImages() async {
    for (final id in widget.problem.imgIds) {
      images.add(Image.network(
        await ImgManager.getImage(id),
        width: double.infinity,
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadContracts();
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Design.backgroundColor,
      body: UploadAnsPageBody(
        problem: widget.problem,
        contract: contract,
        images: images,
      ),
    );
  }
}

class UploadAnsPageBody extends StatelessWidget {
  final ProblemsModel problem;
  final ContractsModel contract;
  final List<Image> images;
  final TextEditingController controller = TextEditingController();

  UploadAnsPageBody({
    super.key,
    required this.problem,
    required this.contract,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    // cal the time from now to the deadline
    final time = contract.deadline.difference(DateTime.now());
    final days = time.inDays;
    final hours = time.inHours;
    final minutes = time.inMinutes;
    final seconds = time.inSeconds;

    final closetTime = days > 0
        ? '$days days'
        : hours > 0
            ? '$hours hours'
            : minutes > 0
                ? '$minutes minutes'
                : '$seconds seconds';

    List<String> imgList = <String>[];

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
                decoration: const BoxDecoration(
                  color: Design.insideColor,
                  borderRadius: Design.outsideBorderRadius,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      problem.title,
                      style: const TextStyle(
                        color: Design.primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                        ),
                        Text(
                          closetTime,
                          style: const TextStyle(
                            color: Design.primaryTextColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: Design.spacing,
                decoration: const BoxDecoration(
                  color: Design.insideColor,
                  borderRadius: Design.outsideBorderRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '題目文字內容',
                      style: TextStyle(
                        color: Design.primaryTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      problem.description,
                      style: const TextStyle(
                        color: Design.primaryTextColor,
                        fontSize: 15,
                      ),
                    ),
                    for (final img in images) img,
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: Design.spacing,
                constraints: const BoxConstraints(
                  minHeight: 300,
                ),
                decoration: const BoxDecoration(
                  color: Design.insideColor,
                  borderRadius: Design.outsideBorderRadius,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: '輸入解答...',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.image, color: Colors.grey, size: 50),
                            Icon(Icons.image, color: Colors.grey, size: 50),
                            Icon(Icons.image, color: Colors.grey, size: 50),
                          ],
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          icon: const Icon(Icons.add_box_outlined,
                              color: Colors.grey, size: 40),
                          onPressed: () {
                            ImgManager.uploadImage().then((value) {
                              imgList.add(value);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ConfirmButtom(
              onPressed: () async {
                if (controller.text.isEmpty) {
                  DialogManager.showInfoDialog(context, '請輸入解答');
                  return;
                }
                Routes.back(context);
                problem.answer = controller.text;
                problem.imgIds = imgList;
                ChatRoomModel chatRoom = ChatRoomModel(
                  id: '',
                  memberIds: [problem.authorId, contract.solverId],
                  messages: [],
                );
                String chatRoomId =
                    await ChatRoomDatabase.addChatRoom(chatRoom);
                problem.chatRoomId = chatRoomId;
                ProblemsDatabase.updateProblem(problem);
                var author = await UsersDatabase.queryUser(problem.authorId);
                author.notices.add("${problem.title}已解答");
                UsersDatabase.updateUser(author);
              },
              name: '上傳',
            ),
          )
        ],
      ),
    );
  }
}
