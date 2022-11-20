import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
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
  bool editing = false;
  int count = 0;
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
            //ShowCurrentTags
            Stack(
              children: [
                Container(
                  padding: Design.spacing,
                  decoration: const BoxDecoration(
                      borderRadius: Design.outsideBorderRadius,
                      color: Design.insideColor),
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
                          if (!editing)
                            for (final tag in tags)
                              ShowTagsWidget(
                                title: tag,
                                isGeneral: true,
                              ),
                          if (editing)
                            for (count = 0; count < tags.length; count++)
                              showEditTags(count),
                        ],
                      ),
                      SizedBox(height: Design.getScreenHeight(context) * 0.01),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 2, 0),
                  alignment: const Alignment(1, 0),
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    //color: const Color.fromARGB(255, 0, 0, 0),
                    onPressed: () {
                      setState(() {
                        editing = !editing;
                        //print(editing);
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: Design.getScreenHeight(context) * 0.02),
            //ShowUsedTagsWidget(tags: usedTags),
            Stack(
              children: [
                Container(
                  padding: Design.spacing,
                  decoration: const BoxDecoration(
                      borderRadius: Design.outsideBorderRadius,
                      color: Design.insideColor),
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: Design.getScreenHeight(context) * 0.1,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '曾經顯示的專業標籤',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: Design.getScreenHeight(context) * 0.02),
                      Wrap(
                        spacing: Design.getScreenHeight(context) * 0.01,
                        runSpacing: Design.getScreenHeight(context) * 0.01,
                        direction: Axis.horizontal,
                        children: [
                          for (count = 0; count < usedTags.length; count++)
                            showUsedTags(count),
                        ],
                      ),
                      SizedBox(height: Design.getScreenHeight(context) * 0.01),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Design.getScreenHeight(context) * 0.02),
            //AddNewLabelText
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

  Widget showEditTags(int which) {
    return Stack(
      children: [
        ShowTagsWidget(
          title: tags[which],
          isGeneral: true,
        ),
        Positioned(
          top: -22.0,
          right: -20.0,
          child: IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.highlight_off,
              color: Color.fromARGB(255, 255, 0, 0),
              size: 15,
            ),
            onPressed: () {
              setState(() {
                removeTagsToUsed(which);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget showUsedTags(int which) {
    return Stack(
      children: [
        ShowTagsWidget(
          title: usedTags[which],
          isGeneral: true,
        ),
        Positioned(
          top: -22.0,
          right: -20.0,
          child: IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 15,
            ),
            onPressed: () {
              setState(() {
                removeUsedTagsToTags(which);
              });
            },
          ),
        ),
      ],
    );
  }

  Future<void> addTags(String text) async {
    tags.add(text);
    final currentUser = await AccountManager.currentUser;
    final newUser = UsersModel(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      pastExpertiseTags: usedTags,
      expertiseTags: tags,
    );

    AccountManager.updateCurrentUser(newUser);
    setState(() {});
    setState(() {});
  }

  Future<void> removeTagsToUsed(int which) async {
    usedTags.add(tags[which]);
    tags.removeAt(which);
    final currentUser = await AccountManager.currentUser;

    final newUser = UsersModel(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      pastExpertiseTags: usedTags,
      expertiseTags: tags,
    );

    AccountManager.updateCurrentUser(newUser);
    setState(() {});
  }

  Future<void> removeUsedTagsToTags(int which) async {
    tags.add(usedTags[which]);
    usedTags.removeAt(which);
    final currentUser = await AccountManager.currentUser;
    
    final newUser = UsersModel(
      id: currentUser.id,
      name: currentUser.name,
      email: currentUser.email,
      pastExpertiseTags: usedTags,
      expertiseTags: tags,
    );

    AccountManager.updateCurrentUser(newUser);
    setState(() {});
  }

  void loadTags() {
    AccountManager.currentUser.then((value) {
      setState(() {
        tags = value.expertiseTags.map((e) => e as String).toList();
        usedTags = value.pastExpertiseTags.map((e) => e as String).toList();
      });
    });

    setState(() {});
  }
}

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
