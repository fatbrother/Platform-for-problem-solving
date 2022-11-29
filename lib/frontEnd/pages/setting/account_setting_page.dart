import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';
import 'package:pops/frontEnd/widgets/setting_bar.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  UsersModel user = UsersModel(id: '', name: '', email: '');

  void loadUserInfo() async {
    user = await AccountManager.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ListView(
        padding: Design.spacing,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: Design.spacing,
            decoration: const BoxDecoration(
              borderRadius: Design.outsideBorderRadius,
              color: Design.insideColor,
            ),
            child: Column(children: [
              const Text('使用者帳號',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              Text(user.name, style: const TextStyle(fontSize: 15)),
            ]),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: Design.spacing,
            decoration: const BoxDecoration(
              borderRadius: Design.outsideBorderRadius,
              color: Design.insideColor,
            ),
            child: Column(children: [
              const Text('信箱',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              Text(user.email, style: const TextStyle(fontSize: 15)),
            ]),
          ),
          const SizedBox(height: 10),
          SettingBar(
            onPressed: () => Routes.push(context, Routes.changePasswordPage),
            name: '更改密碼',
          ),
          const SizedBox(height: 10),
          SettingBar(
            onPressed: deleteAccount,
            name: '刪除帳號',
          ),
        ],
      ),
      backgroundColor: Design.secondaryColor,
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }

  void deleteAccount() async {
    
  }
}
