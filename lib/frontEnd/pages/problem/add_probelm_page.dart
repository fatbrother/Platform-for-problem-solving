import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';

class AddProblemPage extends StatelessWidget {
  AddProblemPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: Design.backgroundColor,
      body: ListView(
        children: [
          Container(
            margin: Design.spacing,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: const TextField(
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: '題目標題',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Design.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text(
                '確認選擇',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}
