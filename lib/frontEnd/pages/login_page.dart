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
    if (AccountManager.isLoggedIn()) {
      Routes.pushReplacement(context, Routes.homeRouteName);
    }
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
              margin: const EdgeInsets.only(top: 100.0),
              padding: Design.spacing,
              decoration: const BoxDecoration(
                color: Design.secondaryColor,
                borderRadius: Design.outsideBorderRadius,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  InputField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 20.0),
                  InputField(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
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
                ],
              ),
            ),
            Center(
              heightFactor: 1,
              child: CircleAvatar(
                radius: 0.2 * Design.getScreenWidth(context),
                backgroundColor: Design.primaryColor,
                backgroundImage: const AssetImage('assets/Logo.png'),
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
      DialogManager.showError(e, context);
      passwordController.clear();
      return;
    }

    setState(() {});
  }

  Future<void> forgotPassword() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InkWell(
          child: Alert(
            title: 'Forgot Password',
            content: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            onPressed: () async {
              try {
                await AccountManager.resetPasswordBySendEmail(emailController.text);
              } catch (e) {
                DialogManager.showError(e, context);
              }
            },
          ),
        );
      },
    );
  }
}
