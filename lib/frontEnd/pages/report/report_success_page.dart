import 'package:flutter/material.dart';
import 'package:pops/backEnd/database.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';

class ReportSuccessPage extends StatelessWidget {
  final ReportsModel report;

  const ReportSuccessPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(backRoute: Routes.selfProblemPage),
      body: ReportSuccessBody(
        report: report,
      ),
    );
  }
}

class ReportSuccessBody extends StatefulWidget {
  final ReportsModel report;

  const ReportSuccessBody({super.key, required this.report});

  @override
  State<ReportSuccessBody> createState() => _ReportSuccessBodyState();
}

class _ReportSuccessBodyState extends State<ReportSuccessBody> {
  UsersModel reporter = UsersModel(id: '', name: '', email: '');
  UsersModel beReporter = UsersModel(id: '', name: '', email: '');
  ProblemsModel problem = ProblemsModel();

  void returnTocken() async {
    reporter = await UsersDatabase.queryUser(widget.report.reporterId);
    problem = await ProblemsDatabase.queryProblem(widget.report.problemId);
    beReporter = await UsersDatabase.queryUser(widget.report.beReporterId);
    reporter.tokens += 10 + problem.rewardToken;
    beReporter.reportNum += 1;
    beReporter.notices.add('${reporter.name}對您的檢舉已通過，請注意您的行為');
    UsersDatabase.updateUser(beReporter);
    UsersDatabase.updateUser(reporter);
  }

  @override
  void initState() {
    super.initState();
    returnTocken();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: Design.spacing,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '檢舉成功',
            style: TextStyle(
              fontSize: 30.0,
              color: Design.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            '系統已退還上架及懸賞代幣，\n感謝您的檢舉。',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.3),
        ],
      ),
    );
  }
}
