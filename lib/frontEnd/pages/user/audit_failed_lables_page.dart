import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class  AuditFailedTagsPage extends StatelessWidget {
  const  AuditFailedTagsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SimpleAppBar(),
      backgroundColor: Design.secondaryColor,
      body: AuditFailedTagsView(),
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
  //audittingTags[?]<--本身是提交日期，內含失敗的詳細情形內容?

  @override
  Widget build(BuildContext context) {
    loadUserInfo();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: <Widget>[
          DateWidget(tag:_auditFailedTag),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          Detailsidget(tag:_auditFailedTag),
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
      height: Design.getScreenHeight(context) * 0.1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Design.insideColor,
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Design.secondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                  "審核失敗",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Design.primaryTextColor),
                  ),
                  Icon(Icons.error_outline,),
                ],  
              ),
            ),
            SizedBox(height: Design.getScreenHeight(context) * 0.008),
            Text(
              "$tag提交",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  color: Design.primaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

//列出此審核失敗的標籤詳細資訊
class Detailsidget extends StatelessWidget {
  final String tag;
  const Detailsidget({super.key, required this.tag});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Design.insideColor,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Design.secondaryColor,
              ),
              child: 
                const Text(
                 "詳細情形",
                 textAlign: TextAlign.center,
                 style: TextStyle(
                     fontSize: 20,
                     color: Design.primaryTextColor),
                 ),
            ),
            SizedBox(height: Design.getScreenHeight(context) * 0.008),
            Text(
              "aaaaaaaaaaaaaaaaaaaaaa內容aaaaaaaaaaaaaaaaaa",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  color: Design.primaryTextColor),
            ),
          ],
        ),
      ),
    );
  }
}