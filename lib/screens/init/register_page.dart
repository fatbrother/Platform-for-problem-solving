import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/widgets/button/login_button.dart';
import 'package:pops/widgets/main/app_bar.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/widgets/input_field.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        backgroundColor: Design.backgroundColor,
        appBar: TitleBar(title: '註冊'),
        body: RegisterBody(),
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      child: Center(
        child: Container(
          padding: Design.spacing,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Design.secondaryColor,
            borderRadius: Design.outsideBorderRadius,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                InputField(
                  hintText: '使用者名稱',
                  controller: userNameController,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                InputField(
                  hintText: '電子郵件',
                  controller: emailController,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                InputField(
                  hintText: '密碼',
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                InputField(
                  hintText: '確認密碼',
                  controller: confirmPasswordController,
                  obscureText: true,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                LoginButton(
                  onPressed: () => signUp(),
                  text: '註冊',
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      DialogManager.showInfoDialog(
        context,
        'Passwords do not match',
      );
      return;
    }

    DialogManager.showInfoDialog(context, "驗證信已寄出，請至信箱收信",
        onOk: () => Routes.back(context));
    try {
      await AccountManager.signUp(
        userNameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
      );
    } catch (e) {
      DialogManager.showInfoDialog(
        context,
        e.toString(),
        onOk: () => Routes.back(context),
      );
      return;
    }
  }
}
