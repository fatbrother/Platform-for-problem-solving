import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/suggest_field.dart';

class ReportSuccessPage extends StatefulWidget {
  const ReportSuccessPage({super.key});
  @override
  State<ReportSuccessPage> createState() => _ReportSuccessPageState();
}

class _ReportSuccessPageState extends State<ReportSuccessPage> {
  TextEditingController reportSuccessController = TextEditingController();
  List<bool> checkList = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Design.backgroundColor,
        body: Container(
          margin: Design.spacing,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Design.getScreenHeight(context) * 0.05),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 35,
                    ),
                  ],
                ),
                const Text(
                  '檢舉成功',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Design.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.05),
                const Text(
                  '點選確定系統將歸還代幣。\n解題者會受到警告。\n感謝您的使用。',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                ReportField(
                  maxline: 15,
                  hintTextFloating: '請提供您寶貴的意見...',
                  controller: reportSuccessController,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.05),
                SendButton(onPressed: () => {}, text: '確認'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
