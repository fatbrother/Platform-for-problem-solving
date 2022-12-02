import 'package:flutter/material.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/input_field.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Design.backgroundColor,
        appBar: AppBar(
          toolbarHeight: 0.1 * Design.getScreenHeight(context),
          titleTextStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Design.primaryColor,
          title: const Text('Login Page'),
        ),
        body: Container(
          margin: Design.spacing,
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Container(
              margin:
                  EdgeInsets.only(top: Design.getScreenHeight(context) * 0.12),
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
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    InputField(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SecondaryButton(
                              onPressed: () {
                                Routes.push(context, Routes.register);
                              },
                              text: 'Register'),
                          const Text('/', textScaleFactor: 1.5),
                          SecondaryButton(
                            onPressed: () => forgotPassword(),
                            text: 'Forgot Password',
                          ),
                        ],
                      ),
                      MainButton(
                        onPressed: () => signIn(),
                        text: 'Login',
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
        ),
      ),
    );
  }

  Future<void> signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      await AccountManager.signIn(email, password);
    } catch (e) {
      DialogManager.showInfoDialog(context, e.toString());
      passwordController.clear();
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
            hintText: 'Enter your email',
          ),
        ), () async {
      try {
        await AccountManager.resetPasswordBySendEmail(emailController.text);
      } catch (e) {
        DialogManager.showInfoDialog(context, e.toString());
      }
    });
  }
}
