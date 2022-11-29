import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';
import 'package:pops/frontEnd/widgets/setting_bar.dart';

class CommonProblemPage extends StatefulWidget {
  const CommonProblemPage({super.key});

  @override
  State<CommonProblemPage> createState() => _CommonProblemPageState();
}

class _CommonProblemPageState extends State<CommonProblemPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: ListView(
        padding: Design.spacing,
        children: <Widget>[
          SettingBar(
            name: "How to use the app",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          SettingBar(
            name: "How to use the app",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          SettingBar(
            name: "How to use the app",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          SettingBar(
            name: "How to use the app",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          SettingBar(
            name: "How to use the app",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          SettingBar(
            name: "How to use the app",
            onPressed: () {},
          ),
          const SizedBox(height: 10),
        ],
      ),
      backgroundColor: Design.secondaryColor,
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}
