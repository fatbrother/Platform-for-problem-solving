import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';
import 'package:pops/frontEnd/widgets/tag.dart';

class SystemLabelsPage extends StatelessWidget {
  const SystemLabelsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
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
    'showingTags': <String>[],
  };

  Future<void> loadAllTags() async {
    var currentUser = await AccountManager.currentUser;
    allTags = <String, List<String>>{};
    allTags['audittingTags'] = currentUser.audittingTags;
    allTags['auditFailedTags'] = currentUser.auditFailedTags;
    allTags['showingTags'] = currentUser.displaySystemTags;
    allTags['notShowingTags'] = currentUser.hideSystemTags;

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
            tags: allTags['showingTags'] ?? <String>[],
            isGeneral: false,
            title: '目前顯示的系統標籤'
          ),
          const SizedBox(height: 10),
          ShowLablesInfoWidget(allTags: allTags),
          const SizedBox(height: 10),
          AddLableWidget(),
        ],
      ),
    );
  }
}

class ShowLablesWidget extends StatelessWidget {
  final String title;
  final List<String> tags;
  final bool isGeneral;

  const ShowLablesWidget({
    super.key,
    required this.title,
    required this.tags,
    required this.isGeneral,
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
                  ShowTagsWidget(
                    title: tag,
                    isGeneral: isGeneral,
                  ),
              ]),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }
}

class ShowLablesInfoWidget extends StatelessWidget {
  final Map<String, List<String>> allTags;

  const ShowLablesInfoWidget({super.key, required this.allTags});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: Design.outsideBorderRadius,
        color: Design.insideColor,
      ),
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          ShowLableColumn(
            title: '審核通過的標籤',
            children: [
              for (int i = 0; i < allTags['showingTags']!.length; i++)
                ShowSystemTableBoxWidget(
                  tag: allTags['showingTags']![i],
                  leftButtonTitle: '隱藏',
                  leftButtonOnPressed: () {
                    // removeDisplayTagsToHideTags(i);
                  },
                  rightButtonTitle: '刪除',
                  rightButtonOnPressed: () {
                    // showDeleteAlertDialog(context, "確認刪除將無法再回復！", 'showingTags', i);
                  },
                ),
              for (int i = 0; i < allTags['notShowingTags']!.length; i++)
                ShowSystemTableBoxWidget(
                  tag: allTags['notShowingTags']![i],
                  leftButtonTitle: '顯示',
                  leftButtonOnPressed: () {
                    // removeHideTagsToDisplayTags(i);
                  },
                  rightButtonTitle: '刪除',
                  rightButtonOnPressed: () {
                    // removeHideTags(i);
                    // showDeleteAlertDialog(context, "確認刪除將無法再回復！", 'notShowingTags', i);
                  },
                ),
            ],
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.02),
          ShowLableColumn(title: '審核失敗的標籤', children: [
            //審核失敗的標籤
            for (final tag in allTags['auditFailedTags']!)
              ShowSystemTableBoxWidget(
                tag: tag,
                leftButtonTitle: '查看',
                leftButtonOnPressed: () {
                  //audit_failed_tags_page
                },
                rightButtonTitle: '刪除',
                rightButtonOnPressed: () {
                  //
                  //showDeleteAlertDialog(context, "確認刪除將無法再回復！");
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
                  //or 顯示該標籤內容
                },
                rightButtonTitle: '刪除',
                rightButtonOnPressed: () {
                  //
                  //showDeleteAlertDialog(context, "確認刪除將無法再回復！");
                },
              ), //顯示所有該分類tags
          ]),
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

class AddLableWidget extends StatefulWidget {
  const AddLableWidget({super.key});

  @override
  State<AddLableWidget> createState() => _AddLableWidgetState();
}

class _AddLableWidgetState extends State<AddLableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: Design.outsideBorderRadius,
        color: Design.insideColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('新增系統認證標籤',
              style: TextStyle(
                fontSize: 20,
                color: Design.primaryTextColor,
              )),
        ],
      ),
    );
  }
}
