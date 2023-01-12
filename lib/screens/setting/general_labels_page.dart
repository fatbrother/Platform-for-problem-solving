import 'package:flutter/material.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/widgets/label/show_labels.dart';
import 'package:pops/widgets/main/scaffold.dart';

class GeneralLabelsPage extends StatefulWidget {
  const GeneralLabelsPage({super.key});

  @override
  State<GeneralLabelsPage> createState() => _GeneralLabelsPageState();
}

class _GeneralLabelsPageState extends State<GeneralLabelsPage> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
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
  UsersModel user = UsersModel();

  Future<void> loadInfo() async {
    user = await AccountManager.currentUser;
    setState(() {
      labels = user.expertiselabels;
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
          ShowlabelsWidget(
            title: '目前顯示標籤',
            labels: labels,
            isGeneral: true,
            onLongPress: deletelabel,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: addlabel,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Design.insideColor,
                borderRadius: Design.outsideBorderRadius,
              ),
              child: const Center(
                child: Text(
                  '新增標籤',
                  style: TextStyle(color: Design.primaryTextColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void deletelabel(String label) {
    DialogManager.showContentDialog(
      context,
      const Text('確定要刪除此標籤嗎？'),
      () {
        setState(() {
          labels.remove(label);
          user.expertiselabels = labels;
          AccountManager.updateCurrentUser(user);
        });
      },
    );
  }

  void addlabel() {
    TextEditingController controller = TextEditingController();
    DialogManager.showContentDialog(
      context,
      TextField(
        controller: controller,
        decoration: const InputDecoration(
          hintText: '請輸入標籤名稱',
          border: InputBorder.none,
        ),
      ),
      () {
        if (controller.text == '') {
          DialogManager.showInfoDialog(
            context,
            '標籤名稱不可為空',
          );
          return;
        }
        if (controller.text.length > 10) {
          DialogManager.showInfoDialog(
            context,
            '標籤名稱過長',
          );
          return;
        }
        if (labels.contains(controller.text)) {
          DialogManager.showInfoDialog(
            context,
            '標籤名稱重複',
          );
          return;
        }
        setState(() {
          labels.add(controller.text);
          user.expertiselabels = labels;
          AccountManager.updateCurrentUser(user);
        });
      },
    );
  }
}
