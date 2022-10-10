import 'package:flutter/material.dart';
import 'package:pops/backEnd/account.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';
  String comfirmPassword = '';
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              onChanged: (value) => setState(() => email = value),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              onChanged: (value) => setState(() => password = value),
            ),
            Text(errorMessage),
            ElevatedButton(
              onPressed: () async {
                try {
                  await AccountManager.signUp('Fatbrother', email, password);
                } catch (e) {
                  setState(() => errorMessage = e.toString());
                }
              },
              child: const Text('Register'),
            ),
          ],
        )),
      ),
    );
  }
}
