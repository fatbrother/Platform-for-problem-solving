import 'package:flutter/material.dart';
import 'package:pops/models/audit_command_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/services/other/label_audit.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/label/show_label_box.dart';
import 'package:pops/widgets/label/show_label_column.dart';
import 'package:pops/widgets/label/show_labels.dart';
import 'package:pops/widgets/main/scaffold.dart';

class SystemLabelsPage extends StatelessWidget {
  const SystemLabelsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: const SystemLabelsView(),
      backgroundColor: Design.secondaryColor,
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}

class SystemLabelsView extends StatefulWidget {
  const SystemLabelsView({super.key});

  @override
  State<SystemLabelsView> createState() => _SystemLabelsViewState();
}

class _SystemLabelsViewState extends State<SystemLabelsView> {
  Map<String, List<String>> alllabels = <String, List<String>>{};
  UsersModel user = UsersModel();
  List<String> imgIds = <String>[];

  Future<void> loadAlllabels() async {
    user = await AccountManager.currentUser;
    alllabels = <String, List<String>>{};
    alllabels['audittinglabels'] = user.audittinglabels;
    alllabels['auditFailedlabels'] = user.auditFailedlabels;
    alllabels['displaySystemlabels'] = user.displaySystemlabels;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAlllabels();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          ShowlabelsWidget(
              onLongPress: deleteShowinglabel,
              labels: alllabels['displaySystemlabels'] ?? <String>[],
              isGeneral: false,
              title: '目前顯示的系統標籤'),
          const SizedBox(height: 10),
          Container(
            decoration: const BoxDecoration(
              borderRadius: Design.outsideBorderRadius,
              color: Design.insideColor,
            ),
            padding: Design.spacing,
            child: Column(
              children: <Widget>[
                ShowLabelColumn(title: '審核失敗的標籤', children: [
                  //審核失敗的標籤
                  for (final label in alllabels['auditFailedlabels']!)
                    ShowLabelBoxWidget(
                      label: label,
                      leftButtonTitle: '查看',
                      leftButtonOnPressed: () {
                        DialogManager.showInfoDialog(
                          context,
                          "標籤名稱：$label 審核失敗",
                        );
                      },
                      rightButtonTitle: '刪除',
                      rightButtonOnPressed: () => deleteAuditFailedlabel(label),
                    ), //顯示所有該分類labels
                ]),
                SizedBox(height: Design.getScreenHeight(context) * 0.02),
                ShowLabelColumn(title: '審核中的標籤', children: [
                  //審核中的標籤
                  for (final label in alllabels['audittinglabels']!)
                    ShowLabelBoxWidget(
                      label: label,
                      leftButtonTitle: '查看',
                      leftButtonOnPressed: () {
                        DialogManager.showInfoDialog(
                            context, "標籤需經由人工審核，可能花費較長時間，請耐心等候。");
                      },
                      rightButtonTitle: '刪除',
                      rightButtonOnPressed: () => deleteAudittinglabel(label),
                    ),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: submitAudit,
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

  void deleteShowinglabel(String labels) {
    DialogManager.showContentDialog(
      context,
      const Text('確定刪除標籤?'),
      () async {
        alllabels['displaySystemlabels']!.remove(labels);
        setState(() {});
        var user = await AccountManager.currentUser;
        user.displaySystemlabels = alllabels['displaySystemlabels']!;
        AccountManager.updateCurrentUser(user);
      },
    );
  }

  void deleteAuditFailedlabel(String labels) async {
    alllabels['auditFailedlabels']!.remove(labels);
    setState(() {});
    var user = await AccountManager.currentUser;
    user.auditFailedlabels = alllabels['auditFailedlabels']!;
    AccountManager.updateCurrentUser(user);
  }

  void deleteAudittinglabel(String label) {
    DialogManager.showContentDialog(context, const Text('確定刪除?'), () async {
      alllabels['audittinglabels']!.remove(label);
      setState(() {});
      var user = await AccountManager.currentUser;
      user.audittinglabels = alllabels['audittinglabels']!;
      AccountManager.updateCurrentUser(user);
    });
  }

  void uploadImg() async {
    try {
      String id = await ImgManager.uploadImage();
      imgIds.add(id);
    } catch (e) {
      DialogManager.showInfoDialog(context, '上傳失敗');
    }
  }

  void submitAudit() {
    TextEditingController titleController = TextEditingController();
    DialogManager.showContentDialog(
      context,
      SizedBox(
        width: Design.getScreenWidth(context) * 0.6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Design.getScreenWidth(context) * 0.3,
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: '請輸入標籤名稱',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: uploadImg,
              icon: const Icon(Icons.image_outlined),
            ),
          ],
        ),
      ),
      () {
        if (titleController.text == '') {
          DialogManager.showInfoDialog(
            context,
            '標籤名稱不可為空',
          );
          return;
        }
        if (titleController.text.length > 10) {
          DialogManager.showInfoDialog(
            context,
            '標籤名稱過長',
          );
          return;
        }
        if (alllabels['audittinglabels']!.contains(titleController.text)) {
          DialogManager.showInfoDialog(
            context,
            '標籤名稱重複',
          );
          return;
        }

        alllabels['audittinglabels']!.add(titleController.text);
        AuditCommandsModel auditCommandsModel = AuditCommandsModel(
          id: '',
          name: titleController.text,
          commanderId: user.id,
          auditImages: imgIds,
        );

        AuditCommandsDatabase.instance.add(auditCommandsModel);
        user.audittinglabels = alllabels['audittinglabels']!;
        AccountManager.updateCurrentUser(user);
        setState(() {});
      },
    );
  }
}
