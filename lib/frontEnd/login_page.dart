import 'package:flutter/material.dart';
import 'package:pops/frontEnd/widgets/input_field.dart';
import '../backEnd/account.dart';
import '../design.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
        margin: Design.outsideSpacing,
        width: double.infinity,
        height: double.infinity,
        child: Stack(children: [
          Container(
            margin: const EdgeInsets.only(top: 100.0),
            padding: Design.outsideSpacing,
            decoration: const BoxDecoration(
              color: Design.secondaryColor,
              borderRadius: Design.outsideBorderRadius,
            ),
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                InputField(
                  hintText: 'Username',
                  controller: usernameController,
                ),
                const SizedBox(height: 20.0),
                InputField(
                  hintText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  child: const Text(
                    'Register',
                    textScaleFactor: 1.5,
                  ),
                  onPressed: () {
                    // TODO: Go to the register page
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    signIn(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Design.primaryColor,
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.3 * Design.getScreenWidth(context),
                        vertical: 0.03 * Design.getScreenHeight(context)),
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Login'),
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
              )),
        ]),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    String email = usernameController.text;
    String password = passwordController.text;

    try {
      await AccountManager.signIn(email, password);
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

      passwordController.clear();
    }
  }
}
