import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class SortProblemPage extends StatefulWidget {
  const SortProblemPage({super.key});

  @override
  State<SortProblemPage> createState() => _SortProblemPage();
}

class _SortProblemPage extends State<SortProblemPage> {
  UsersModel user = UsersModel(id: '', name: '', email: '');
  List<FolderModel> folderList = [];
  String folderName = '';

  Future<void> loadFolder(String folderName) async {
    user = await AccountManager.currentUser;
    if (folderName == '') {
      folderList = user.folders;
    } else {
      folderList = user.folders
          .where((element) => element.name.contains(folderName))
          .toList();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadFolder('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController titleController = TextEditingController();
          DialogManager.showContentDialog(
            context,
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '請輸入資料夾名稱',
              ),
            ),
            () => setState(() {
              FolderModel newFolder = FolderModel(
                  name: titleController.text, problemIds: <String>[]);
              // check if the folder name already exists
              if (newFolder.name.length > 15) {
                DialogManager.showInfoDialog(context, '資料夾名稱過長');
                return;
              }
              if (folderList
                  .any((FolderModel folder) => folder.name == newFolder.name)) {
                DialogManager.showInfoDialog(context, '資料夾名稱已存在');
                return;
              }
              if (newFolder.name == "") {
                newFolder.name = "未命名資料夾${folderList.length + 1}";
              }
              folderList.add(newFolder);
              user.folders = folderList;
              UsersDatabase.updateUser(user);
            }),
          );
        },
        backgroundColor: Design.primaryColor,
        child: const ImageIcon(
          AssetImage('assets/icon/folderadd.png'),
          color: Colors.black,
        ),
      ),
      backgroundColor: Design.secondaryColor,
      appBar: SearchBar(
        onSelected: loadFolder,
        getSuggestions: (String text) {
          if (text == '') {
            return [];
          } else {
            List<String> res = [];
            for (final folder in folderList) {
              if (folder.name.contains(text)) {
                res.add(folder.name);
              }
            }
            return res;
          }
        },
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.sortProblemPage),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (final folder in folderList)
                      FolderBox(
                        folder: folder,
                        onTap: () => Routes.push(context, Routes.folderPage,
                            arguments: folder),
                        onLongPress: () {
                          DialogManager.showContentDialog(
                              context, Text('確定要刪除 ${folder.name} 嗎？'), () {
                            folderList.remove(folder);
                            user.folders = folderList;
                            UsersDatabase.updateUser(user);
                            setState(() {});
                          });
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FolderBox extends StatefulWidget {
  final FolderModel folder;
  final void Function() onTap;
  final void Function() onLongPress;

  const FolderBox({
    super.key,
    required this.folder,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  State<FolderBox> createState() => _FolderBoxState();
}

class _FolderBoxState extends State<FolderBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: SizedBox(
        width: Design.getScreenWidth(context) * 0.5,
        height: Design.getScreenWidth(context) * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/icon/folder2.png'),
              fit: BoxFit.contain,
            ),
            Text(
              widget.folder.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
