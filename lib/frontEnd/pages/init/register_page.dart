import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/input_field.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/routes.dart';

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
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
          padding: Design.spacing,
          child: Center(
            child: Container(
              padding: Design.spacing,
              decoration: const BoxDecoration(
                color: Design.secondaryColor,
                borderRadius: Design.outsideBorderRadius,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Design.getScreenHeight(context) * 0.01),
                    InputField(
                      hintText: 'Username',
                      controller: userNameController,
                    ),
                    SizedBox(height: Design.getScreenHeight(context) * 0.03),
                    InputField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    SizedBox(height: Design.getScreenHeight(context) * 0.03),
                    InputField(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: true,
                    ),
                    SizedBox(height: Design.getScreenHeight(context) * 0.03),
                    InputField(
                      hintText: 'Confirm Password',
                      controller: confirmPasswordController,
                      obscureText: true,
                    ),
                    SizedBox(height: Design.getScreenHeight(context) * 0.03),
                    MainButton(
                      onPressed: () => signUp(),
                      text: 'Register',
                    ),
                    SizedBox(height: Design.getScreenHeight(context) * 0.01),
                  ],
                ),
              ),
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

    try {
      await AccountManager.signUp(
        userNameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
      );
    } catch (e) {
      DialogManager.showInfoDialog(context, e.toString());
      return;
    }

    if (mounted) {
      Routes.pushReplacement(context, Routes.verifyPhone);
    }
  }
}
