import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/tag.dart';

class SystemTagPage extends StatelessWidget {
  const SystemTagPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(198, 192, 220, 236),
      appBar: MyAppBar.titleAppBar(title: '系統標籤'),
      body: const SystemLabelsView(),
    );
  }
}

class SystemLabelsView extends StatefulWidget {
  const SystemLabelsView({super.key});

  @override
  State<SystemLabelsView> createState() => _SystemLabelsViewState();
}

class _SystemLabelsViewState extends State<SystemLabelsView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Design.spacing,
      child: Column(
        children: <Widget>[
          const ShowSystemTagsWidget(),
          SizedBox(height: Design.getScreenHeight(context) * 0.03),
          const ShowSystemTableWidget(),
        ],
      ),
    );
  }
}

class ShowSystemTagsWidget extends StatefulWidget {
  const ShowSystemTagsWidget({super.key});

  @override
  State<ShowSystemTagsWidget> createState() => _ShowSystemTagsWidgetState();
}

class _ShowSystemTagsWidgetState extends State<ShowSystemTagsWidget> {
  List<String> tags = <String>[];

  @override
  Widget build(BuildContext context) {
    loadTags();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Design.insideColor //color沒放在decoration裡的話會overflow
          ),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Design.getScreenHeight(context) * 0.15,
      ),
      child: Column(
        children: [
          const Text(
            '目前顯示的系統標籤',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          Wrap(
              spacing: 5,
              runSpacing: 5,
              direction: Axis.horizontal,
              children: [
                for (final tag in tags) ShowTagsWidget(title: tag),
              ]),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }

  Future<void> loadTags() async {
    var currentUser = await AccountManager.currentUser;
    tags = currentUser.expertiseTags.map((e) => e as String).toList();
    debugPrint('tags: $tags');
    setState(() {});
  }
}

class ShowSystemTableWidget extends StatefulWidget {
  const ShowSystemTableWidget({super.key});

  @override
  State<ShowSystemTableWidget> createState() => _ShowSystemTableWidgetState();
}

class _ShowSystemTableWidgetState extends State<ShowSystemTableWidget> {
  Map<String, List<String>> allTags = <String, List<String>>{};

  @override
  Widget build(BuildContext context) {
    loadAllTags();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Design.insideColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          ShowLableColumn(
            title: '審核通過的標籤',
            children: [
              for (final tag in allTags['showingTags']!)
                ShowSystemTableBoxWidget(
                  tag: tag,
                  leftButtonTitle: '隱藏',
                  leftButtonOnPressed: () {},
                  rightButtonTitle: '刪除',
                  rightButtonOnPressed: () {},
                ),
              for (final tag in allTags['notShowingTags']!)
                ShowSystemTableBoxWidget(
                  tag: tag,
                  leftButtonTitle: '顯示',
                  leftButtonOnPressed: () {},
                  rightButtonTitle: '刪除',
                  rightButtonOnPressed: () {},
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
                leftButtonOnPressed: () {},
                rightButtonTitle: '刪除',
                rightButtonOnPressed: () {},
              ), //顯示所有該分類tags
          ]),
          SizedBox(height: Design.getScreenHeight(context) * 0.02),
          ShowLableColumn(title: '審核中的標籤', children: [
            //審核中的標籤
            for (final tag in allTags['audittingTags']!)
              ShowSystemTableBoxWidget(
                tag: tag,
                leftButtonTitle: '查看',
                leftButtonOnPressed: () {},
                rightButtonTitle: '刪除',
                rightButtonOnPressed: () {},
              ), //顯示所有該分類tags
          ]),
        ],
      ),
    );
  }

  Future<void> loadAllTags() async {
    var currentUser = await AccountManager.currentUser;
    allTags = <String, List<String>>{};
    allTags['audittingTags'] =
        currentUser.audittingTags.map((tag) => tag as String).toList();
    allTags['auditFailedTags'] =
        currentUser.auditFailedTags.map((tag) => tag as String).toList();
    allTags['showingTags'] =
        currentUser.expertiseTags.map((tag) => tag as String).toList();
    allTags['notShowingTags'] =
        currentUser.pastExpertiseTags.map((tag) => tag as String).toList();

    setState(() {});
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
    return Container(
      //審核失敗的標籤
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Design.getScreenHeight(context) * 0.15,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(198, 192, 220, 236),
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
          for (final child in children) child,
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
        SizedBox(height: Design.getScreenHeight(context) * 0.01),
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
                  backgroundColor: const Color.fromARGB(198, 192, 220, 236),
                  onPressed: widget.leftButtonOnPressed,
                ),
              ),
              Container(
                alignment: const Alignment(1, 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                //padding: const EdgeInsets.symmetric(horizontal: 0.0),
                //height: 36,
                child: ColorButton(
                  title: widget.rightButtonTitle,
                  backgroundColor: const Color.fromARGB(255, 224, 210, 209),
                  onPressed: widget.rightButtonOnPressed,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Design.getScreenHeight(context) * 0.01), //間距
      ],
    );
  }
}