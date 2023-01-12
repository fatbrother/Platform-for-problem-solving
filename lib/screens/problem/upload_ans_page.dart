import 'package:flutter/material.dart';
import 'package:pops/models/chatroom_model.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/services/other/chat_room.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/services/user/user.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/add_img_row.dart';
import 'package:pops/widgets/main/app_bar.dart';
import 'package:pops/widgets/buttons.dart';

class UploadAnsPage extends StatefulWidget {
  final ProblemsModel problem;

  const UploadAnsPage({super.key, required this.problem});

  @override
  State<UploadAnsPage> createState() => _UploadAnsPageState();
}

class _UploadAnsPageState extends State<UploadAnsPage> {
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
    return Scaffold(
      appBar: const GoBackBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Design.backgroundColor,
      body: UploadAnsPageBody(
        problem: widget.problem,
        images: images,
      ),
    );
  }
}

class UploadAnsPageBody extends StatefulWidget {
  final ProblemsModel problem;
  final List<Image> images;

  const UploadAnsPageBody({
    super.key,
    required this.problem,
    required this.images,
  });

  @override
  State<UploadAnsPageBody> createState() => _UploadAnsPageBodyState();
}

class _UploadAnsPageBodyState extends State<UploadAnsPageBody> {
  List<String> imgList = <String>[];
  List<Image> answerImages = <Image>[];
  final TextEditingController controller = TextEditingController();

  void loadImages() async {
    for (final id in imgList) {
      answerImages.add(Image.network(
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
    final time = widget.problem.deadline.difference(DateTime.now());
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

    return Container(
      height: double.infinity,
      padding: Design.spacing,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
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
                        widget.problem.title,
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
                        widget.problem.description,
                        style: const TextStyle(
                          color: Design.primaryTextColor,
                          fontSize: 15,
                        ),
                      ),
                      for (final img in widget.images) img,
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
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          minHeight: 300,
                        ),
                        width: double.infinity,
                        child: TextField(
                          controller: controller,
                          maxLines: null,
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: '輸入解答...',
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      for (final img in answerImages) img,
                      AddImgRow(onPressed: addImg),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ConfirmButtom(
              onPressed: upLoad,
              name: '上傳',
            ),
          )
        ],
      ),
    );
  }

  void addImg() async {
    try {
      String id = await ImgManager.uploadImage();
      imgList.add(id);
      answerImages.add(Image.network(
        await ImgManager.getImageUrl(id),
        width: double.infinity,
      ));
      setState(() {});
    } catch (e) {
      DialogManager.showInfoDialog(context, '上傳失敗');
    }
  }

  void upLoad() async {
    if (controller.text.isEmpty) {
      DialogManager.showInfoDialog(context, '請輸入解答');
      return;
    }
    Routes.back(context);
    widget.problem.answer = controller.text;
    widget.problem.answerImgIds = imgList;
    ChatRoomModel chatRoom = ChatRoomModel(
      id: '',
      memberIds: [widget.problem.authorId, widget.problem.solverId],
      messages: [],
    );
    String chatRoomId = await ChatRoomDatabase.instance.add(chatRoom);
    widget.problem.chatRoomId = chatRoomId;
    ProblemsDatabase.instance.update(widget.problem);
    var author = await UsersDatabase.instance.query(widget.problem.authorId);
    author.notices.add("${widget.problem.title}已解答");
    UsersDatabase.instance.update(author);
  }
}
