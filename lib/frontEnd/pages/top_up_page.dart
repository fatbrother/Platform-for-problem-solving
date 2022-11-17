import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.secondaryColor,
      appBar: MyAppBar.titleAppBar(title: '儲值'),
      body: const TopUpView(),
    );
  }
}

class TopUpView extends StatefulWidget {
  const TopUpView({super.key});

  @override
  State<TopUpView> createState() => _TopUpView();
}

class _TopUpView extends State<TopUpView> {
  var money = 0;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          //輸入儲值金額
          SizedBox(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Design.insideColor,
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _controller,
                onChanged: (text) {
                  setState(() {
                    money =
                        int.parse(_controller.text); //string converts to int
                  });
                },
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
              onTap: () {
                String message = judge(money);
                DialogManager.showAlertDialog(context, message);
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

  String judge(int money) {
    String message;
    if (money < 0) {
      message = "金額有誤，儲值失敗";
    } else {
      message = "代幣增加" "$money";
    }
    return message;
  }
}
