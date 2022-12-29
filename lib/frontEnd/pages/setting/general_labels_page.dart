import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/pages/setting/system_labels_page.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';
import 'package:pops/frontEnd/widgets/tag.dart';

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
  UsersModel user = UsersModel(id: '', name: '', email: '');

  Future<void> loadInfo() async {
    user = await AccountManager.currentUser;
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Design.insideColor),
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: Design.getScreenHeight(context) * 0.15,
            ),
            child: Column(
              children: [
                const Text(
                  '目前顯示的標籤',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
                Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    direction: Axis.horizontal,
                    children: [
                      for (final tag in labels)
                        GestureDetector(
                          onLongPress: () {
                            DialogManager.showContentDialog(
                              context,
                              const Text('確定要刪除此標籤嗎？'),
                              () {
                                setState(() {
                                  labels.remove(tag);
                                  user.expertiseTags = labels;
                                  AccountManager.updateCurrentUser(user);
                                });
                              },
                            );
                          },
                          child: ShowTagsWidget(
                            title: tag,
                            isGeneral: true,
                          ),
                        ),
                    ]),
                SizedBox(height: Design.getScreenHeight(context) * 0.01),
              ],
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
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
                  if (controller.text.isNotEmpty) {
                    setState(() {
                      if (labels.contains(controller.text)) {
                        DialogManager.showInfoDialog(
                          context,
                          '標籤名稱重複',
                        );
                        return;
                      }
                      labels.add(controller.text);
                      user.expertiseTags = labels;
                      AccountManager.updateCurrentUser(user);
                    });
                  }
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
