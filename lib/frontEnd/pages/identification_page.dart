import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.secondaryColor,
      body: const IdentificationView(),
    );
  }
}

class IdentificationView extends StatefulWidget {
  const IdentificationView({super.key});

  @override
  State<IdentificationView> createState() => _IdentificationViewState();
}

class _IdentificationViewState extends State<IdentificationView> {
  String _phoneNumber = "未設定";
  String _personalState = "未啟用";

  @override
  Widget build(BuildContext context) {
    loadUserInfo();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: <Widget>[
          const MyAppBar(),
          PhoneNumberWidget(phoneNumber: _phoneNumber == "" ? "未設定" : _phoneNumber),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          PersonalStateWidget(personalState: _personalState),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          const ChangePhoneNumberWiget(),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          Vertification(
            onPressed: () {
              DialogManager.showAlertDialog(context, "簡訊已發送");
            },
          ),
        ],
      ),
    );
  }

  Future<void> loadUserInfo() async {
    UsersModel currentUser = await AccountManager.currentUser;
    setState(() {
      _phoneNumber = currentUser.phone;
      _personalState = currentUser.isVerified() ? "已啟用" : "未啟用";
    });
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
          style: const TextStyle(
              fontSize: 20,
              color: Design.primaryTextColor),
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
              fontSize: 20,
              color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }
}

//修改手機號碼按鈕
class ChangePhoneNumberWiget extends StatelessWidget {
  const ChangePhoneNumberWiget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Design.getScreenHeight(context) * 0.05,
      child: InkWell(
        onTap: () {
          //-->修改手機號碼changePhoneNumber
          Routes.push(context, Routes.changePhoneNumberPage);
        },
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Design.insideColor,
            ),
            alignment: Alignment.center,
            child: const Text(
              '修改手機號碼',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          Container(
            alignment: const Alignment(1, 0),
            child: const Icon(
              Icons.double_arrow,
              color: Color.fromARGB(177, 59, 59, 59),
            ),
          )
        ]),
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
