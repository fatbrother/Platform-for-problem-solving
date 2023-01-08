import 'package:flutter/material.dart';
import 'package:pops/services/database.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/app_bar.dart';
import 'package:pops/models/report_model.dart';

class ReportWaitPage extends StatefulWidget {
  final String reportId;
  const ReportWaitPage({super.key, required this.reportId});

  @override
  State<ReportWaitPage> createState() => _ReportWaitPageState();
}

class _ReportWaitPageState extends State<ReportWaitPage> {
  ReportsModel report = ReportsModel();

  void loadReport() async {
    report = await ReportsDataBase.instance.query(widget.reportId);
    if (report.isVerified == true) {
      // ignore: use_build_context_synchronously
      Routes.pushReplacement(
        context,
        report.isSucceeded ? Routes.reportSuccessPage : Routes.reportFailPage,
        arguments: report,
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.reportId != '') {
      loadReport();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GoBackBar(backRoute: Routes.selfProblemPage),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Text(
            "檢舉已送出，請等待審核",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
