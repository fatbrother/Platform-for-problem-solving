import 'package:flutter/material.dart';

import '../../backEnd/user/account.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        leading: IconButton(
            onPressed: () {
              AccountManager.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout)),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
