import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppBar(),
      backgroundColor: Design.secondaryColor,
      body: TopUpView(),
    );
  }
}

class TopUpView extends StatefulWidget {
  const TopUpView({super.key});

  @override
  State<TopUpView> createState() => _TopUpView();
}

class _TopUpView extends State<TopUpView> {
  final TextEditingController _controller = TextEditingController();
  bool seeMiddle = true;
  bool seeDown = false;
  int tapping = 1;
  void _changed(int tapping) {
    setState(() {
      if (tapping == 1) {
        seeMiddle = true;
        seeDown = false;
      } else if (tapping == 2) {
        seeMiddle = false;
        seeDown = true;
      }
    });
  }

  UsersModel user = UsersModel(id: '', name: '', email: '');

  Future<void> loadUserInfo() async {
    user = await AccountManager.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Design.insideColor,
              borderRadius: Design.outsideBorderRadius,
            ),
            padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Text('目前餘額：${user.tokens}',
                style: const TextStyle(
                    fontSize: 20, color: Design.secondaryTextColor)),
          ),
          const SizedBox(height: 20),
          SizedBox(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Design.insideColor,
              ),
              alignment: Alignment.center,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _controller,
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: '輸入儲值金額',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.03), //選擇支付方式
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                //上部分
                child: SvgPicture.asset(
                  'assets/top_up/top.svg',
                ),
              ),
              SizedBox(
                //中部份
                child: InkWell(
                  onTap: () {
                    _changed(1);
                  },
                  child: Stack(children: <Widget>[
                    SvgPicture.asset(
                      'assets/top_up/middle.svg',
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
                      child: Visibility(
                        visible: seeMiddle,
                        child: const Icon(
                          Icons.radio_button_checked,
                          color: Design.primaryColor,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                //下部分
                child: InkWell(
                  onTap: () {
                    _changed(2);
                  },
                  child: Stack(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(0),
                      child: SvgPicture.asset(
                        'assets/top_up/down.svg',
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
                      child: Visibility(
                        visible: seeDown,
                        child: const Icon(
                          Icons.radio_button_checked,
                          color: Design.primaryColor,
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          //確認儲值按鈕
          SizedBox(
            height: Design.getScreenHeight(context) * 0.07,
            child: InkWell(
              onTap: () async {
                try {
                  int money = int.parse(_controller.text);
                  _controller.clear();

                  if (money <= 0) {
                    DialogManager.showInfoDialog(context, '請輸入正確金額');
                  } else {
                    DialogManager.showInfoDialog(context, '儲值成功');
                    user.tokens += money;
                    await AccountManager.updateCurrentUser(user);
                    loadUserInfo();
                  }
                } catch (e) {
                  DialogManager.showInfoDialog(context, '請輸入正確金額');
                  return;
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Design.insideColor,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '確認儲值',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
