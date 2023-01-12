import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/main/app_bar.dart';

class ReportFailPage extends StatelessWidget {
  const ReportFailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GoBackBar(backRoute: Routes.selfProblemPage),
      backgroundColor: Design.backgroundColor,
      body: ReportFailBody(),
    );
  }
}

class ReportFailBody extends StatelessWidget {
  const ReportFailBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Design.spacing,
      padding: Design.spacing,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '檢舉失敗',
              style: TextStyle(
                fontSize: 30.0,
                color: Design.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              '系統無法退還代幣，\n感謝您的檢舉。',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Design.getScreenHeight(context) * 0.3),
          ],
        ),
      ),
    );
  }
}
