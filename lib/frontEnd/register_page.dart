import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pops/design.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/input_field.dart';
import 'package:pops/backEnd/account.dart';

import '../routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (AccountManager.isLoggedIn()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.home);
      });
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
          title: const Text('Register Page'),
        ),
        body: Container(
          margin: Design.outsideSpacing,
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Container(
              padding: Design.outsideSpacing,
              decoration: const BoxDecoration(
                color: Design.secondaryColor,
                borderRadius: Design.outsideBorderRadius,
              ),
              child: Column(
                children: [
                  InputField(
                    hintText: 'Username',
                    controller: userNameController,
                  ),
                  const SizedBox(height: 20.0),
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
                  InputField(
                    hintText: 'Confirm Password',
                    controller: confirmPasswordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  MainButton(
                    onPressed: () => signUp(),
                    text: 'Register',
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    try {
      AccountManager.signUp(
        userNameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String message = e.toString();
          message = message.substring(message.indexOf(':') + 2);

          return AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    while (!AccountManager.isEmailVerified()) {
      await Future.delayed(const Duration(seconds: 1));
    }

    if (AccountManager.isEmailVerified()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Routes.home);
      });
    }
  }
}
