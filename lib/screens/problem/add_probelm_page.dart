import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/tag_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/services/other/tag.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/other/add_img_row.dart';
import 'package:pops/widgets/button/confirm_button.dart';
import 'package:pops/widgets/main/scaffold.dart';

class AddProblemPage extends StatelessWidget {
  const AddProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      backgroundColor: Design.backgroundColor,
      body: const AddProblemPageBody(),
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}

class AddProblemPageBody extends StatefulWidget {
  const AddProblemPageBody({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProblemPageBody> createState() => _AddProblemPageBodyState();
}

class _AddProblemPageBodyState extends State<AddProblemPageBody> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController rewardTokenController = TextEditingController();
  UsersModel user = UsersModel();
  List<String> imageIdList = [];
  List<Image> imageList = [];
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    user = await AccountManager.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      children: [
        TitleTextField(titleController: titleController),
        const SizedBox(height: 10),
        Container(
          padding: Design.spacing,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              TextField(
                controller: descriptionController,
                maxLines: 10,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  hintText: '題目描述、圖片',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                  contentPadding: EdgeInsets.all(0),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
              for (final image in imageList)
                SizedBox(
                  width: double.infinity,
                  child: image,
                ),
              AddImgRow(onPressed: addImage),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: Design.spacing,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('新增標籤',
                      style: TextStyle(
                          fontSize: 17, color: Design.secondaryTextColor)),
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.add_box_outlined,
                        color: Colors.grey, size: 40),
                    onPressed: addtag,
                  ),
                ],
              ),
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                runSpacing: 10,
                spacing: 10,
                children: [
                  for (final tag in tags)
                    GestureDetector(
                      onLongPress: () => deleteTag(tag),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Design.secondaryColor,
                        ),
                        child: Text(tag,
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white)),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: Design.spacing,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: TextField(
            maxLines: 1,
            controller: rewardTokenController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              hintText: '價格',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ConfirmButtom(
            name: '確認',
            onPressed: () {
              addProblem();
            }),
      ],
    );
  }

  void addProblem() {
    final title = titleController.text;
    final description = descriptionController.text;
    final rewardToken = rewardTokenController.text == ''
        ? 0
        : int.parse(rewardTokenController.text);
    if (title == '' || description == '' || rewardToken == 0) {
      DialogManager.showInfoDialog(context, '請輸入完整資料');
      return;
    }
    if (tags.isEmpty) {
      DialogManager.showInfoDialog(context, '請至少輸入一個標籤');
      return;
    }
    if (rewardToken < 0) {
      DialogManager.showInfoDialog(context, '價格不得為負數');
      return;
    }

    DialogManager.showContentDialog(context, const Text('系統將收取10代幣上架手續費'), () {
      final problem = ProblemsModel(
        id: '',
        title: title,
        description: description,
        authorId: user.id,
        authorName: user.name,
        imgIds: imageIdList,
        tags: tags,
        baseToken: rewardToken,
        solveCommendIds: [],
        createdAt: DateTime.now(),
      );
      if (user.tokens < 10 + rewardToken) {
        DialogManager.showInfoDialog(context, '代幣不足');
      } else {
        DialogManager.showInfoDialog(context, '上架成功', onOk: () async {
          Routes.back(context);
          String id = await ProblemsDatabase.instance.add(problem);
          user.askProblemIds.add(id);
          user.tokens -= 10 + rewardToken;
          for (final tag in tags) {
            try {
              TagsModel tagModel = TagsDatabase.instance.query(tag);
              tagModel.problemsWithTag.add(id);
              TagsDatabase.instance.update(tagModel);
            } catch (e) {
              TagsModel tagModel = TagsModel(
                id: '',
                name: tag,
                problemsWithTag: [id],
              );
              TagsDatabase.instance.add(tagModel);
            }
          }
          AccountManager.updateCurrentUser(user);
        });
      }
    });
  }

  Future<void> addImage() async {
    try {
      String imgId = await ImgManager.uploadImage();
      Image img = Image.network(await ImgManager.getImageUrl(imgId));
      setState(() {
        imageIdList.add(imgId);
        imageList.add(img);
      });
    } catch (e) {
      DialogManager.showInfoDialog(context, '上傳失敗');
      return;
    }
  }

  void addtag() {
    TextEditingController tagController = TextEditingController();
    DialogManager.showContentDialog(
        context,
        TextField(
          controller: tagController,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            hintText: '輸入標籤',
            hintStyle:
                TextStyle(color: Design.secondaryTextColor, fontSize: 17),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ), () {
      setState(() {
        if (tagController.text.length > 10) {
          DialogManager.showInfoDialog(context, '標籤長度過長');
          return;
        }
        if (tags.contains(tagController.text)) {
          DialogManager.showInfoDialog(context, '標籤重複');
          return;
        }
        if (tagController.text == '') {
          DialogManager.showInfoDialog(context, '標籤不得為空');
          return;
        }
        if (tagController.text.contains(' ')) {
          DialogManager.showInfoDialog(context, '標籤不得包含空格');
          return;
        }
        if (tags.length >= 5) {
          DialogManager.showInfoDialog(context, '標籤不得超過五個');
          return;
        }

        tags.add(tagController.text);
      });
    });
  }

  void deleteTag(String tag) {
    DialogManager.showContentDialog(
      context,
      const Text('確定刪除標籤?'),
      () {
        tags.remove(tag);
        setState(() {});
      },
    );
  }
}

class TitleTextField extends StatelessWidget {
  const TitleTextField({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: TextField(
        controller: titleController,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          hintText: '題目標題',
          hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
