import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/suggest_field.dart';

class ReportFailPage extends StatefulWidget {
  const ReportFailPage({super.key});
  @override
  State<ReportFailPage> createState() => _ReportFailPageState();
}

class _ReportFailPageState extends State<ReportFailPage> {
  TextEditingController reportSuccessController = TextEditingController();

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
                const MyAppBar(),
                const Text(
                  '檢舉失敗',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Design.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                const Text(
                  '系統無法退還代幣，\n但您還是能對解題者評分評論。\n感謝您的使用。',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.025),
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
