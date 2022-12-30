import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';
import 'package:pops/frontEnd/widgets/setting_bar.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: Design.secondaryColor,
      body: const IdentificationView(),
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}

class IdentificationView extends StatefulWidget {
  const IdentificationView({super.key});

  @override
  State<IdentificationView> createState() => _IdentificationViewState();
}

class _IdentificationViewState extends State<IdentificationView> {
  UsersModel user = UsersModel(id: '', name: '', email: '');

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          PhoneNumberWidget(phoneNumber: user.phone == "" ? "未設定" : user.phone),
          const SizedBox(height: 10),
          PersonalStateWidget(
              personalState: user.isPhoneVerified ? "已驗證" : "未驗證"),
          const SizedBox(height: 10),
          SettingBar(
            name: '修改手機號碼',
            onPressed: () {
              TextEditingController controller = TextEditingController();
              DialogManager.showContentDialog(
                context,
                TextField(
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: "請輸入手機號碼",
                    border: InputBorder.none,
                  ),
                  controller: controller,
                ),
                () {
                  if (controller.text == "") {
                    DialogManager.showInfoDialog(context, "請輸入手機號碼");
                    return;
                  }
                  if (controller.text.length != 10) {
                    DialogManager.showInfoDialog(context, "手機號碼格式錯誤");
                    return;
                  }
                  if (controller.text[0] != "0" || controller.text[1] != "9") {
                    DialogManager.showInfoDialog(context, "手機號碼格式錯誤");
                    return;
                  }
                  // check if phone number is number
                  for (int i = 0; i < controller.text.length; i++) {
                    if (controller.text[i].codeUnitAt(0) < 48 ||
                        controller.text[i].codeUnitAt(0) > 57) {
                      DialogManager.showInfoDialog(context, "手機號碼格式錯誤");
                      return;
                    }
                  }
                  if (controller.text == user.phone) {
                    DialogManager.showInfoDialog(context, "手機號碼未變更");
                    return;
                  }
                  user.phone = controller.text;
                  user.isPhoneVerified = false;
                  AccountManager.updateCurrentUser(user);
                  loadUserInfo();
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Vertification(
            onPressed: () async {
              try {
                TextEditingController controller = TextEditingController();
                String verificationId = await AccountManager.sendSms(user.phone);
                if (mounted) {
                  DialogManager.showContentDialog(
                    context,
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "請輸入驗證碼",
                        border: InputBorder.none,
                      ),
                      controller: controller,
                    ),
                    () async {
                      if (controller.text == "") {
                        DialogManager.showInfoDialog(context, "請輸入驗證碼");
                        return;
                      }

                      try {
                        await AccountManager.verifyPhoneNumber(
                            verificationId, controller.text);
                      }
                      catch (e) {
                        DialogManager.showInfoDialog(context, "驗證碼錯誤");
                        return;
                      }

                      user.isPhoneVerified = true;
                      AccountManager.updateCurrentUser(user);
                    },
                  );
                }
              } catch (e) {
                DialogManager.showInfoDialog(context, "請先設定手機號碼");
                return;
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> loadUserInfo() async {
    user = await AccountManager.currentUser;
    setState(() {});
  }
}

//列出手機號碼
class PhoneNumberWidget extends StatelessWidget {
  final String phoneNumber;
  const PhoneNumberWidget({super.key, required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Design.getScreenHeight(context) * 0.08,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Design.insideColor,
        ),
        alignment: Alignment.center,
        child: Text(
          "手機號碼\n$phoneNumber",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Design.primaryTextColor),
        ),
      ),
    );
  }
}

//啟用與否
class PersonalStateWidget extends StatelessWidget {
  final String personalState;
  const PersonalStateWidget({super.key, required this.personalState});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Design.getScreenHeight(context) * 0.05,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Design.insideColor,
        ),
        alignment: Alignment.center,
        child: Text(
          personalState,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }
}

//傳送驗證碼按鈕
class Vertification extends StatelessWidget {
  final void Function() onPressed;

  const Vertification({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Design.getScreenHeight(context) * 0.05,
      child: InkWell(
        onTap: onPressed,
        child: Container(
            //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Design.insideColor,
            ),
            alignment: Alignment.center,
            child: const Text(
              '傳送驗證碼',
              textAlign: TextAlign.center,
              style: TextStyle(
                  //letterSpacing: 10,
                  fontSize: 20,
                  //fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            )),
      ),
    );
  }
}
