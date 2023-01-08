import 'package:flutter/material.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/report_model.dart';
import 'package:pops/services/database.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';
import 'package:pops/widgets/buttons.dart';
import 'package:pops/widgets/suggest_field.dart';

class ReportPage extends StatefulWidget {
  final String reporterId;
  final String beReporterId;
  final ProblemsModel problem;

  const ReportPage({
    super.key,
    required this.reporterId,
    required this.beReporterId,
    required this.problem,
  });
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
        appBar: const GoBackBar(
          backRoute: Routes.homePage,
        ),
        backgroundColor: Design.backgroundColor,
        body: Container(
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
                for (int i = 0; i < ReportsModel.reportsTypes.length; i++)
                  CheckButton(
                    text: ReportsModel.reportsTypes[i],
                    backgroundColor: Design.backgroundColor,
                    ischeck: check == i,
                    onPressed: () => setState(
                      () {
                        check = i;
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
                    onPressed: () async {
                      DialogManager.showInfoDialog(context, '您的檢舉將進入審核，請耐心等候。');

                      ReportsModel newReport = ReportsModel(
                        id: '',
                        reportType: ReportsModel.reportsTypes[check],
                        reportDescription: ratingController.text,
                        reporterId: widget.reporterId,
                        beReporterId: widget.beReporterId,
                        problemId: widget.problem.id,
                      );
                      String reportId =
                          await ReportsDataBase.instance.add(newReport);
                      widget.problem.reportId = reportId;
                      widget.problem.isSolved = true;
                      ProblemsDatabase.instance.update(widget.problem);
                      // ignore: use_build_context_synchronously
                      Routes.pushReplacement(context, Routes.reportWaitPage,
                          arguments: reportId);
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
