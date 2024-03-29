import 'package:flutter/material.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/widgets/button/login_button.dart';
import 'package:pops/widgets/button/register_text_button.dart';
import 'package:pops/widgets/main/app_bar.dart';
import 'package:pops/widgets/other/input_field.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Design.backgroundColor,
        appBar: TitleBar(title: '登入'),
        body: LoginBody(),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Design.spacing,
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: Design.getScreenHeight(context) * 0.12),
          padding: Design.spacing,
          decoration: const BoxDecoration(
            color: Design.secondaryColor,
            borderRadius: Design.outsideBorderRadius,
          ),
          child: Container(
            padding: Design.spacing,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                InputField(
                  hintText: '信箱',
                  controller: emailController,
                ),
                InputField(
                  hintText: '密碼',
                  controller: passwordController,
                  obscureText: true,
                ),
                Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RegisterTextButton(
                          onPressed: () {
                            Routes.push(context, Routes.register);
                          },
                          text: '註冊'),
                      const Text('/', textScaleFactor: 1.5),
                      RegisterTextButton(
                        onPressed: () => forgotPassword(),
                        text: '忘記密碼',
                      ),
                    ],
                  ),
                  LoginButton(
                    onPressed: () => signIn(),
                    text: '登入',
                  ),
                ]),
                SizedBox(height: 0.05 * Design.getScreenHeight(context)),
              ],
            ),
          ),
        ),
        Center(
          heightFactor: 1,
          child: CircleAvatar(
            radius: 0.2 * Design.getScreenWidth(context),
            backgroundColor: Design.insideColor,
            backgroundImage: const AssetImage('assets/logoInLogin.png'),
          ),
        ),
      ]),
    );
  }

  Future<void> signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      await AccountManager.signIn(email, password);
    } catch (e) {
      if (e.toString().contains('Email is not verified')) {
        DialogManager.showInfoDialog(context, '尚未驗證信箱，請至信箱收取驗證信');
        return;
      }
      if (e
          .toString()
          .contains('no user record corresponding to this identifier')) {
        DialogManager.showInfoDialog(context, '無此帳號');
        emailController.clear();
        passwordController.clear();
        return;
      }
      if (e.toString().contains('password is invalid')) {
        DialogManager.showInfoDialog(context, '密碼錯誤');
        passwordController.clear();
        return;
      }

      DialogManager.showInfoDialog(context, e.toString());
      passwordController.clear();
      return;
    }

    var currentUser = await AccountManager.currentUser;
    if (currentUser.reportNum > 3) {
      if (mounted) {
        DialogManager.showInfoDialog(context, '您已被檢舉超過三次，已被停權');
      }
      return;
    }

    if (mounted) {
      Routes.pushReplacement(context, Routes.homeRouteName);
    }
  }

  Future<void> forgotPassword() async {
    DialogManager.showContentDialog(
        context,
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
            hintText: '請輸入信箱',
          ),
        ), () async {
      try {
        await AccountManager.resetPasswordBySendEmail(emailController.text);
        if (mounted) {
          DialogManager.showInfoDialog(context, '已寄送重設密碼信至信箱');
        }
      } catch (e) {
        DialogManager.showInfoDialog(context, e.toString());
      }
    });
  }
}
