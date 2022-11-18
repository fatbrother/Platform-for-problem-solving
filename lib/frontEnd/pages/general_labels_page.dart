import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/tag.dart';

class UserTagPage extends StatelessWidget {
  const UserTagPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(198, 192, 220, 236),
      appBar: AppBar(
        //build arrow_back
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color.fromARGB(255, 0, 0, 0),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            );
          },
        ),
        //AppBar color and word
        backgroundColor: Design.backgroundColor,
        title: const Text('一般標籤',
            style: TextStyle(color: Design.primaryTextColor)),
        centerTitle: true,
      ),
      body: const GeneralLabelsView(),
    );
  }
}

class GeneralLabelsView extends StatefulWidget {
  const GeneralLabelsView({super.key});

  @override
  State<GeneralLabelsView> createState() => _GeneralLabelsViewState();
}

class _GeneralLabelsViewState extends State<GeneralLabelsView> {
  TextEditingController textController = TextEditingController();
  List<String> tags = <String>[];
  List<String> usedTags = <String>[];

  @override
  Widget build(BuildContext context) {
    loadTags();
    return Container(
      decoration: const BoxDecoration(color: Design.backgroundColor),
      padding: Design.spacing,
      child: Container(
        padding: Design.spacing,
        decoration: const BoxDecoration(
            color: Design.secondaryColor,
            borderRadius: Design.outsideBorderRadius),
        child: Column(
          children: [
            ShowCurrentTagsWidget(tags: tags),
            SizedBox(height: Design.getScreenHeight(context) * 0.02),
            ShowUsedTagsWidget(tags: usedTags),
            SizedBox(height: Design.getScreenHeight(context) * 0.02),
            //AddNewLabelText:59~96
            SizedBox(
              height: 50,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 12, 10, 0),
                    decoration: const BoxDecoration(
                      borderRadius: Design.outsideBorderRadius,
                      color: Design.insideColor,
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: textController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: '新增標籤',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(1, 0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline,
                      ),
                      onPressed: () => setState(
                        () {
                          addTags(textController.text);
                          textController.clear();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Design.getScreenHeight(context) * 0.02),
            const InstructionsWiget(),
          ],
        ),
      ),
    );
  }

  Future<void> addTags(String text) async {
    tags.add(text);
    final currentUser = await AccountManager.currentUser;
    currentUser.pastExpertiseTags = tags;
    AccountManager.updateCurrentUser();
    setState(() {});
  }

  void loadTags() {}
}

class ShowCurrentTagsWidget extends StatelessWidget {
  final List<String> tags;
  const ShowCurrentTagsWidget({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      decoration: const BoxDecoration(
          borderRadius: Design.outsideBorderRadius,
          color: Design.insideColor //color沒放在decoration裡的話會overflow
          ),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Design.getScreenHeight(context) * 0.1,
      ),
      child: Column(
        children: [
          const Text(
            '目前顯示的專業標籤',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.02),
          Wrap(
            spacing: Design.getScreenHeight(context) * 0.01,
            runSpacing: Design.getScreenHeight(context) * 0.01,
            direction: Axis.horizontal,
            children: [
              for (final tag in tags) ShowTagsWidget(title: tag),
            ],
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }
}

class ShowUsedTagsWidget extends StatelessWidget {
  final List<String> tags;

  const ShowUsedTagsWidget({super.key, required this.tags});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      decoration: const BoxDecoration(
        borderRadius: Design.outsideBorderRadius,
        color: Design.insideColor, //color沒放在decoration裡的話會overflow
      ),
      constraints:
          BoxConstraints(minHeight: Design.getScreenHeight(context) * 0.1),
      width: double.infinity,
      child: Column(children: [
        const Text(
          '曾使用過的專業標籤',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: Design.getScreenHeight(context) * 0.02,
        ),
        SizedBox(
          child: Wrap(
            spacing: Design.getScreenHeight(context) * 0.01,
            runSpacing: Design.getScreenHeight(context) * 0.01,
            direction: Axis.vertical,
            children: [
              for (final tag in tags) ShowTagsWidget(title: tag),
            ],
          ),
        ),
        SizedBox(
          height: Design.getScreenHeight(context) * 0.01,
        ),
      ]),
    );
  }
}

//24.2, 18
//const Color.fromARGB(255, 240, 235, 116),系統認證標籤顏色

//說明頁面按鈕
class InstructionsWiget extends StatelessWidget {
  const InstructionsWiget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Design.getScreenHeight(context) * 0.05,
      child: InkWell(
        onTap: () {
          //-->說明頁面
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePhoneNumberPage()));
        },
        child: Stack(children: <Widget>[
          Container(
            //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
            decoration: const BoxDecoration(
              borderRadius: Design.outsideBorderRadius,
              color: Design.insideColor,
            ),
            alignment: Alignment.center,
            child: const Text(
              '說明',
              textAlign: TextAlign.center,
              style: TextStyle(
                  //letterSpacing: 10,
                  fontSize: 18,
                  //fontWeight: FontWeight.bold,
                  color: Design.secondaryTextColor),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            alignment: const Alignment(1, 0),
            child: const Icon(
              Icons.double_arrow,
              color: Color.fromARGB(177, 59, 59, 59),
            ),
          )
        ]),
      ),
    );
  }
}