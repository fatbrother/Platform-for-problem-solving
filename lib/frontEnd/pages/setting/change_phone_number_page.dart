import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';

class ChangePhoneNumberPage extends StatelessWidget {
  const ChangePhoneNumberPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: Design.secondaryColor,
      body: const ChangePasswordView(),
      currentIndex: Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}

String judge(String againNewNumber, String firstNewNumber) {
  var message = "";
  //若輸入的InputOldPassword和資料庫存放的資料不同時，message = "舊密碼輸入錯誤";
  //密碼是否符合規則的判斷
  if (firstNewNumber == againNewNumber) {
    message = "手機號碼修改成功";
  } else {
    message = "兩次新號碼輸入不相同";
  }
  return message;
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  var oldNumber = "";
  var firstNewNumber = "";
  var againNewNumber = "";
  var message = "";
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          //輸入新號碼
          SizedBox(
            height: 56,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _textController1,
                onChanged: (text) {
                  setState(() {
                    firstNewNumber = _textController1.text;
                  });
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: '輸入新手機號碼',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 19), //空
          //確認新號碼
          SizedBox(
            height: 56,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 2, 8, 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              alignment: Alignment.center,
              child: TextField(
                controller: _textController2,
                onChanged: (text) {
                  setState(() {
                    againNewNumber = _textController2.text;
                  });
                },
                maxLines: 1,
                decoration: const InputDecoration(
                  hintText: '確認新手機號碼',
                  border: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 19), //空
          //確認修改按鈕
          SizedBox(
            height: 35,
            child: InkWell(
              onTap: () {
                message = judge(againNewNumber, firstNewNumber);
                if (message == "手機號碼修改成功") oldNumber = againNewNumber; //修改手機號碼
                showInfoDialog(context, message);
              },
              child: Container(
                  //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '確認修改',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        //letterSpacing: 10,
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

//show AlertDialog
showInfoDialog(BuildContext context, String message) {
  AlertDialog dialog = AlertDialog(
    //title: const Text("Confirm Dialog"),
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      SizedBox(
        width: 600,
        height: 40,
        child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(198, 192, 220, 236)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ))),
          child: const Text("確認",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      )
    ],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // Show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
