import 'package:flutter/material.dart';
import 'package:pops/models/audit_command_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/services/other/lable_audit.dart';
import 'package:pops/services/user/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/buttons.dart';
import 'package:pops/widgets/scaffold.dart';
import 'package:pops/widgets/tag.dart';

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
  Map<String, List<String>> allTags = <String, List<String>>{
    'audittingTags': <String>[],
    'auditFailedTags': <String>[],
    'notShowingTags': <String>[],
  };
  UsersModel user = UsersModel(id: '', name: '', email: '');
  List<String> imgIds = <String>[];

  Future<void> loadAllTags() async {
    user = await AccountManager.currentUser;
    allTags = <String, List<String>>{};
    allTags['audittingTags'] = user.audittingTags;
    allTags['auditFailedTags'] = user.auditFailedTags;
    allTags['showingTags'] = user.displaySystemTags;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAllTags();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          ShowLablesWidget(
              onLongPress: (String tag) {
                DialogManager.showContentDialog(
                  context,
                  const Text('確定刪除標籤?'),
                  () async {
                    allTags['showingTags']!.remove(tag);
                    setState(() {});
                    var user = await AccountManager.currentUser;
                    user.displaySystemTags = allTags['showingTags']!;
                    AccountManager.updateCurrentUser(user);
                  },
                );
              },
              tags: allTags['showingTags'] ?? <String>[],
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
                ShowLableColumn(title: '審核失敗的標籤', children: [
                  //審核失敗的標籤
                  for (final tag in allTags['auditFailedTags']!)
                    ShowSystemTableBoxWidget(
                      tag: tag,
                      leftButtonTitle: '查看',
                      leftButtonOnPressed: () {
                        DialogManager.showInfoDialog(
                          context,
                          "標籤名稱：$tag 審核失敗",
                        );
                      },
                      rightButtonTitle: '刪除',
                      rightButtonOnPressed: () async {
                        allTags['auditFailedTags']!.remove(tag);
                        setState(() {});
                        var user = await AccountManager.currentUser;
                        user.auditFailedTags = allTags['auditFailedTags']!;
                        AccountManager.updateCurrentUser(user);
                      },
                    ), //顯示所有該分類tags
                ]),
                SizedBox(height: Design.getScreenHeight(context) * 0.02),
                ShowLableColumn(title: '審核中的標籤', children: [
                  //審核中的標籤
                  for (final tag in allTags['audittingTags']!)
                    ShowSystemTableBoxWidget(
                      tag: tag,
                      leftButtonTitle: '查看',
                      leftButtonOnPressed: () {
                        DialogManager.showInfoDialog(
                            context, "標籤需經由人工審核，可能花費較長時間，請耐心等候。");
                      },
                      rightButtonTitle: '刪除',
                      rightButtonOnPressed: () {
                        DialogManager.showContentDialog(
                            context, const Text('確定刪除?'), () async {
                          allTags['audittingTags']!.remove(tag);
                          setState(() {});
                          var user = await AccountManager.currentUser;
                          user.audittingTags = allTags['audittingTags']!;
                          AccountManager.updateCurrentUser(user);
                        });
                      },
                    ),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
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
                        onPressed: () async {
                          try {
                            String id = await ImgManager.uploadImage();
                            imgIds.add(id);
                          } catch (e) {
                            DialogManager.showInfoDialog(context, '上傳失敗');
                          }
                        },
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
                  if (allTags['audittingTags']!
                      .contains(titleController.text)) {
                    DialogManager.showInfoDialog(
                      context,
                      '標籤名稱重複',
                    );
                    return;
                  }

                  allTags['audittingTags']!.add(titleController.text);
                  AuditCommandsModel auditCommandsModel = AuditCommandsModel(
                    id: '',
                    name: titleController.text,
                    commanderId: user.id,
                    auditImages: imgIds,
                  );

                  AuditCommandsDatabase.addAuditCommand(auditCommandsModel);
                  user.audittingTags = allTags['audittingTags']!;
                  AccountManager.updateCurrentUser(user);
                  setState(() {});
                },
              );
            },
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
}

class ShowLablesWidget extends StatelessWidget {
  final String title;
  final List<String> tags;
  final bool isGeneral;
  final Function(String) onLongPress;

  const ShowLablesWidget({
    super.key,
    required this.title,
    required this.tags,
    required this.isGeneral,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Design.insideColor),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Design.getScreenHeight(context) * 0.15,
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          Wrap(
              spacing: 5,
              runSpacing: 5,
              direction: Axis.horizontal,
              children: [
                for (final tag in tags)
                  GestureDetector(
                    onLongPress: () => onLongPress(tag),
                    child: ShowLableWidget(
                      title: tag,
                      isGeneral: isGeneral,
                    ),
                  ),
              ]),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }
}

class ShowLableColumn extends StatelessWidget {
  const ShowLableColumn({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    // add sizebox between child of children
    List<Widget> childrenWithSizeBox = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      childrenWithSizeBox.add(children[i]);
      if (i != children.length - 1) {
        childrenWithSizeBox
            .add(SizedBox(height: Design.getScreenHeight(context) * 0.02));
      }
    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Design.getScreenHeight(context) * 0.1,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: Design.outsideBorderRadius,
        color: Color.fromARGB(136, 160, 182, 195),
      ),
      child: Column(
        children: [
          //標題
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Design.primaryTextColor,
            ),
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          for (final child in childrenWithSizeBox) child,
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }
}

class ShowSystemTableBoxWidget extends StatefulWidget {
  final String tag;
  final String leftButtonTitle;
  final void Function() leftButtonOnPressed;
  final String rightButtonTitle;
  final void Function() rightButtonOnPressed;

  const ShowSystemTableBoxWidget({
    super.key,
    required this.tag,
    required this.leftButtonTitle,
    required this.leftButtonOnPressed,
    required this.rightButtonTitle,
    required this.rightButtonOnPressed,
  });

  @override
  State<ShowSystemTableBoxWidget> createState() =>
      _ShowSystemTableBoxWidgetState();
}

class _ShowSystemTableBoxWidgetState extends State<ShowSystemTableBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Design.getScreenHeight(context) * 0.05,
          decoration: const BoxDecoration(
            color: Design.insideColor,
          ),
          child: Stack(
            children: [
              Container(
                alignment: const Alignment(-1, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Text(
                  widget.tag,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Design.primaryTextColor,
                  ),
                ),
              ),
              Container(
                alignment: const Alignment(0.4, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ColorButton(
                  title: widget.leftButtonTitle,
                  backgroundColor: const Color.fromARGB(136, 160, 182, 195),
                  onPressed: widget.leftButtonOnPressed,
                ),
              ),
              Container(
                alignment: const Alignment(1, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ColorButton(
                  title: widget.rightButtonTitle,
                  backgroundColor: const Color.fromARGB(255, 212, 199, 198),
                  onPressed: widget.rightButtonOnPressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
