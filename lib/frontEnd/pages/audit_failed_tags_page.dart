import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class IdentificationPage extends StatelessWidget {
  const IdentificationPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.secondaryColor,
      appBar: MyAppBar.titleAppBar(title: '審核結果'),
      body: const AuditFailedTagsView(),
    );
  }
}

class AuditFailedTagsView extends StatefulWidget {
  const AuditFailedTagsView({super.key});

  @override
  State<AuditFailedTagsView> createState() => _AuditFailedTagsViewState();
}

class _AuditFailedTagsViewState extends State<AuditFailedTagsView> {
  final String _auditFailedTag = '2020/07/09';//提交日期

  @override
  Widget build(BuildContext context) {
    loadUserInfo();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: <Widget>[
          DateWidget(tag:_auditFailedTag),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          //Detailsidget(tag:_auditFailedTag),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          
        ],
      ),
    );
  }

  Future<void> loadUserInfo() async {
    UsersModel currentUser = await AccountManager.currentUser;
    setState(() {
      //_auditFailedTag = currentUser.auditFailedTags[0];
    });
  }
}

//列出此審核失敗的標籤提交日期
class DateWidget extends StatelessWidget {
  final String tag;
  const DateWidget({super.key, required this.tag});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Design.getScreenHeight(context) * 0.08,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Design.insideColor,
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Design.primaryColor,
              ),
              child: Row(
                children: [
                  const Text(
                  "審核失敗",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Design.primaryTextColor),
                  ),
                  const Icon(Icons.error_outline,),
                ],  
              ),
            ),
            Text(
              "$tag提交",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20,
                  color: Design.primaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}