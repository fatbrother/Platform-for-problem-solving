import 'package:flutter/material.dart';
import 'package:pops/pages/widgets/input_field.dart';
import '../context/design.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80.0,
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
            decoration: BoxDecoration(
              color: Design.secondaryColor,
              borderRadius: BorderRadius.circular(Design.outsideBorderRadius),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                const InputField(hintText: 'Username'),
                const SizedBox(height: 20.0),
                const InputField(hintText: 'Password'),
                const SizedBox(height: 20.0),
                TextButton(onPressed: () {}, child: const Text('Register', textScaleFactor: 1.5,)),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Design.primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 20.0),
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
          const Center(
              heightFactor: 1,
              child: CircleAvatar(
                radius: 80.0,
                backgroundColor: Design.primaryColor,
                backgroundImage: AssetImage('assets/Logo.png'),
              )),
        ]),
      ),
    );
  }
}