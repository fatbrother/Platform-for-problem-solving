import 'package:pops/frontEnd/design.dart';
import 'package:flutter/material.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';

///void main() {
//  runApp(const MyApp());
//}

class CommonProblemPage extends StatelessWidget {
  CommonProblemPage({super.key});
  final List<String> problemList = [
    "問題A",
    "問題B",
    "問題C",
    "問題B",
    "問題B",
    "問題B",
    "問題B",
    "問題B",
    "問題B",
    "問題B",
    "問題B",
    "問題B",
    "問題B"
  ];

  @override
  Widget build(BuildContext context) {
    return
        //onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        //child:
        Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(currentIndex: 0),
      backgroundColor: Design.secondaryColor,
      body: Column(
        children: [
          SizedBox(height: Design.getScreenHeight(context) * 0.06),
          Row(
            children: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.arrow_back),
                iconSize: 35,
              ),
            ],
          ),
          Container(
            margin: Design.spacing,
            child: SizedBox(
              height: Design.getScreenHeight(context) * 0.76,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (final title in problemList)
                      LinkButton(
                          text: title,
                          backgroundColor: Design.backgroundColor,
                          onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
