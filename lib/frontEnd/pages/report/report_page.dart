import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/suggest_field.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  TextEditingController ratingController = TextEditingController();
  int check = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const SimpleAppBar(),
        backgroundColor: Design.backgroundColor,
        body: Container(
          margin: Design.spacing,
          padding: Design.spacing,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  '請提出檢舉原因',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Design.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                CheckButton(
                  text: '空白答案',
                  backgroundColor: Design.backgroundColor,
                  ischeck: check == 0,
                  onPressed: () => setState(
                    () {
                      check = 0;
                    },
                  ),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                CheckButton(
                  text: '不雅字眼',
                  backgroundColor: Design.backgroundColor,
                  ischeck: check == 1,
                  onPressed: () => setState(
                    () {
                      check = 1;
                    },
                  ),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                CheckButton(
                  text: '答案與問題無關',
                  backgroundColor: Design.backgroundColor,
                  ischeck: check == 2,
                  onPressed: () => setState(
                    () {
                      check = 2;
                    },
                  ),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                CheckButton(
                  text: '其他',
                  backgroundColor: Design.backgroundColor,
                  ischeck: check == 3,
                  onPressed: () => setState(
                    () {
                      check = 3;
                    },
                  ),
                ),
                ReportField(
                  maxline: 15,
                  hintTextFloating: '請對檢舉原因加以解釋...',
                  controller: ratingController,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.02),
                SendButton(
                    onPressed: () {
                      DialogManager.showInfoDialog(
                          context, '您的檢舉將進入審核，所需時間較長，請耐心等候。');
                    },
                    text: '送出'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
