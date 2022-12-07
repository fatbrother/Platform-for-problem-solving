import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/pages/setting/system_labels_page.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';

class GeneralLabelsPage extends StatefulWidget {
  const GeneralLabelsPage({super.key});

  @override
  State<GeneralLabelsPage> createState() => _GeneralLabelsPageState();
}

class _GeneralLabelsPageState extends State<GeneralLabelsPage> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: Design.secondaryColor,
      body: const GeneralLabelsPageBody(),
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}

class GeneralLabelsPageBody extends StatefulWidget {
  const GeneralLabelsPageBody({super.key});

  @override
  State<GeneralLabelsPageBody> createState() => _GeneralLabelsPageBodyState();
}

class _GeneralLabelsPageBodyState extends State<GeneralLabelsPageBody> {
  List<String> labels = [];
  List<String> pastLabels = [];

  Future<void> loadInfo() async {
    UsersModel user = await AccountManager.currentUser;
    setState(() {
      labels = user.expertiseTags;
      pastLabels = user.pastExpertiseTags;
    });
  }

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          ShowLablesWidget(
            tags: labels,
            isGeneral: true,
            title: '目前顯示的專業標籤',
          ),
          const SizedBox(height: 10),
          ShowLablesWidget(
            tags: pastLabels,
            isGeneral: true,
            title: '曾使用過的專業標籤',
          ),
        ],
      ),
    );
  }
}
