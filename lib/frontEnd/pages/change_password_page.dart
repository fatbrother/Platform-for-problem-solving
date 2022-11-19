import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/input_field.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.secondaryColor,
      body: const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _resentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordCheckController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: <Widget>[
          const MyAppBar(),
          //輸入舊密碼
          SingleInputField(
            controller: _resentPasswordController,
            hintText: '請輸入舊密碼',
            obscureText: true,
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.03), //空
          //輸入新密碼
          SingleInputField(
            controller: _newPasswordController,
            hintText: '請輸入新密碼',
            obscureText: true,
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.03), //空
          //確認新密碼
          SingleInputField(
            controller: _newPasswordCheckController,
            hintText: '請確認新密碼',
            obscureText: true,
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.03), //空
          //確認修改按鈕+更改密碼
          SizedBox(
            height: Design.getScreenHeight(context) * 0.05, //空
            child: InkWell(
              onTap: resetPassword,
              child: Container(
                //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Design.insideColor,
                ),
                alignment: Alignment.center,
                child: const Text(
                  '確認修改',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    //letterSpacing: 10,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Design.primaryTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void resetPassword() {
    String resentPassword = _resentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String newPasswordCheck = _newPasswordCheckController.text;

    try {
      AccountManager.verifyPassword(resentPassword).then((value) {
        if (!value) {
          DialogManager.showAlertDialog(
            context,
            '請輸入正確的密碼',
          );
          return;
        }
      });
    } catch (e) {
      DialogManager.showAlertDialog(
        context,
        '請輸入正確的密碼',
      );
      return;
    }

    if (newPassword != newPasswordCheck) {
      DialogManager.showAlertDialog(context, '請確認新密碼是否正確');
    } else {
      try {
        AccountManager.resetPassword(newPassword)
            .then((value) => DialogManager.showAlertDialog(context, '密碼修改成功'));
      } catch (e) {
        DialogManager.showAlertDialog(context, '密碼修改失敗');
      }
    }
  }
}
