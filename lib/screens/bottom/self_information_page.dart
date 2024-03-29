import 'package:flutter/material.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/other/setting_bar.dart';
import 'package:pops/widgets/label/label.dart';

class SelfInformationPage extends StatelessWidget {
  const SelfInformationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Design.secondaryColor,
      body: SelfInfoPageBody(),
    );
  }
}

class SelfInfoPageBody extends StatefulWidget {
  const SelfInfoPageBody({super.key});

  @override
  State<SelfInfoPageBody> createState() => _SelfInfoPageBodyState();
}

class _SelfInfoPageBodyState extends State<SelfInfoPageBody> {
  UsersModel user = UsersModel(id: '', email: '', name: '');
  Image headshot = Image.asset('assets/icon/defultUserIcon.png');

  Future<void> loadUserInfo() async {
    user = await AccountManager.currentUser;
    if (user.headshotId != '') {
      try {
        headshot = Image.network(await ImgManager.getImageUrl(user.headshotId));
      } catch (e) {
        // pass
      }
    }
    setState(() {});
  }

  void changeUserName(String newName) async {
    user.name = newName;
    await AccountManager.updateCurrentUser(user);
  }

  void logOut() async {
    DialogManager.showContentDialog(context, const Text('確定登出？'), () async {
      await AccountManager.signOut();
      // ignore: use_build_context_synchronously
      Routes.pushReplacement(context, Routes.login);
    });
  }

  void topUp() {
    Routes.push(context, Routes.topUpPage);
  }

  void commonProblem() {
    Routes.push(context, Routes.commonProblemPage);
  }

  void setting() {
    Routes.push(context, Routes.settingPage);
  }

  void addLabel() {
    Routes.push(context, Routes.addLabelPage);
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          UserIcon(headshot: headshot, user: user),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          NameBar(user: user),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          ScoreBar(user: user),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          SelfIntroductionBar(user: user),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          SelfTagBar(user: user),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          SettingBar(name: '編輯標籤', onPressed: addLabel),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          SettingBar(name: '儲值', onPressed: topUp),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          SettingBar(name: '設定', onPressed: setting),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          SettingBar(name: '登出', onPressed: logOut),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }
}

class SelfTagBar extends StatelessWidget {
  const SelfTagBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var tag in user.expertiselabels) {
      children.add(
        ShowLabelWidget(
          title: tag,
          isGeneral: true,
        ),
      );
    }
    for (var tag in user.displaySystemlabels) {
      children.add(ShowLabelWidget(
        title: tag,
        isGeneral: false,
      ));
    }
    if (children.isEmpty) {
      children.add(
        const Text(
          '尚未設定標籤',
          style: TextStyle(
            color: Design.primaryTextColor,
            fontSize: 18,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: Design.spacing,
      decoration: const BoxDecoration(
        color: Design.insideColor,
        borderRadius: Design.outsideBorderRadius,
      ),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: children,
      ),
    );
  }
}

class SelfIntroductionBar extends StatefulWidget {
  const SelfIntroductionBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UsersModel user;

  @override
  State<SelfIntroductionBar> createState() => _SelfIntroductionBarState();
}

class _SelfIntroductionBarState extends State<SelfIntroductionBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_controller.text == "") {
      _controller.text = widget.user.selfIntroduction;
    }
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Design.insideColor,
        borderRadius: Design.outsideBorderRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: const Text("自我介紹", style: TextStyle(fontSize: 20)),
              ),
              IconButton(
                onPressed: changeState,
                icon: const Icon(
                  Icons.edit,
                  color: Design.primaryColor,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              _controller.text == "" ? "尚未填寫" : _controller.text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  void changeState() {
    DialogManager.showContentDialog(
        context,
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: '請輸入自我介紹',
          ),
        ), () {
      widget.user.selfIntroduction = _controller.text;
      AccountManager.updateCurrentUser(widget.user);
      setState(() {});
    });
  }
}

class ScoreBar extends StatelessWidget {
  const ScoreBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Routes.push(context, Routes.ratePage, arguments: user),
      child: Container(
        width: double.infinity,
        height: Design.getScreenHeight(context) * 0.048,
        decoration: BoxDecoration(
          color: Design.insideColor,
          borderRadius:
              BorderRadius.circular(Design.getScreenHeight(context) * 0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                const ImageIcon(
                  AssetImage('assets/icon/assert.png'),
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                Text(user.reportNum.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Design.getScreenHeight(context) * 0.025,
                    )),
              ],
            ),
            Row(
              children: [
                const Icon(
                  Icons.star_border,
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                Text(
                  (user.score /
                          (user.numberOfScores == 0 ? 1 : user.numberOfScores))
                      .toStringAsFixed(1),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Design.getScreenHeight(context) * 0.025,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class NameBar extends StatefulWidget {
  const NameBar({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UsersModel user;

  @override
  State<NameBar> createState() => _NameBarState();
}

class _NameBarState extends State<NameBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_controller.text == "") _controller.text = widget.user.name;
    return Container(
      width: double.infinity,
      height: Design.getScreenHeight(context) * 0.048,
      decoration: BoxDecoration(
        color: Design.insideColor,
        borderRadius:
            BorderRadius.circular(Design.getScreenHeight(context) * 0.05),
      ),
      child: Stack(
        children: [
          Center(
            child: Center(
              child: Text(
                _controller.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: changeName,
              icon: const Icon(
                Icons.edit,
                color: Design.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeName() {
    DialogManager.showContentDialog(
        context,
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: "請輸入名字",
            border: InputBorder.none,
          ),
        ), () {
      if (_controller.text == "") {
        DialogManager.showInfoDialog(context, "名字不可為空");
        return;
      }
      if (_controller.text.length > 10) {
        DialogManager.showInfoDialog(context, "名字不可超過10個字");
        return;
      }
      widget.user.name = _controller.text;
      AccountManager.updateCurrentUser(widget.user);
      setState(() {});
    });
  }
}

class UserIcon extends StatelessWidget {
  final Image headshot;
  final UsersModel user;

  const UserIcon({
    Key? key,
    required this.headshot,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Design.getScreenWidth(context) / 1.9,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Design.insideColor,
                radius: Design.getScreenWidth(context) / 5,
                foregroundImage: headshot.image,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              onPressed: () async {
                try {
                  String id = await ImgManager.uploadImage();
                  if (user.headshotId != '') {
                    ImgManager.deleteImage(user.headshotId);
                  }
                  user.headshotId = id;
                  AccountManager.updateCurrentUser(user);
                } catch (e) {
                  DialogManager.showInfoDialog(context, "上傳失敗");
                }
              },
              icon: const Icon(
                Icons.photo_camera,
                size: 30,
                color: Color.fromARGB(255, 58, 58, 58),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
