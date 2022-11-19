import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/suggest_field.dart';


class RatingResultPage extends StatefulWidget {
  const RatingResultPage({super.key});
  @override
  State<RatingResultPage> createState() => _RatingResultPageState();
}

class _RatingResultPageState extends State<RatingResultPage> {
  TextEditingController ratingController = TextEditingController();
  List<bool> checkList = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MyAppBar.titleAppBar(title: "檢舉原因"),
        backgroundColor: Design.backgroundColor,
        body: Container(
          margin: Design.spacing,
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
                  ischeck: checkList[0],
                  onPressed: () => setState(
                    () {
                      if (checkList[0]) {
                        checkList[0] = false;
                      } else {
                        checkList[0] = true;
                      }
                    },
                  ),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                CheckButton(
                  text: '不雅字眼',
                  backgroundColor: Design.backgroundColor,
                  ischeck: checkList[1],
                  onPressed: () => setState(
                    () {
                      if (checkList[1]) {
                        checkList[1] = false;
                      } else {
                        checkList[1] = true;
                      }
                    },
                  ),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                CheckButton(
                  text: '答案與問題無關',
                  backgroundColor: Design.backgroundColor,
                  ischeck: checkList[2],
                  onPressed: () => setState(
                    () {
                      if (checkList[2]) {
                        checkList[2] = false;
                      } else {
                        checkList[2] = true;
                      }
                    },
                  ),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                CheckButton(
                  text: '其他',
                  backgroundColor: Design.backgroundColor,
                  ischeck: checkList[3],
                  onPressed: () => setState(
                    () {
                      if (checkList[3]) {
                        checkList[3] = false;
                      } else {
                        checkList[3] = true;
                      }
                    },
                  ),
                ),
                ReportField(
                  maxline: 12,
                  hintTextFloating: '請對檢舉原因加以解釋...',
                  controller: ratingController,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.02),
                SendButton(onPressed: () {}, text: '送出'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}