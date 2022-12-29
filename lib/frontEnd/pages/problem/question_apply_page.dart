import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:pops/backEnd/other/img.dart';
import 'package:pops/backEnd/problem/contract.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';

class QuestionApplyPage extends StatelessWidget {
  final ProblemsModel problem;

  const QuestionApplyPage({
    Key? key,
    required this.problem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      backgroundColor: Design.backgroundColor,
      body: MyCustomForm(problem: problem),
      currentIndex: Routes.bottomNavigationRoutes.indexOf(Routes.homePage),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final ProblemsModel problem;

  const MyCustomForm({
    super.key,
    required this.problem,
  });

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  DateTime currentTime = DateTime.now();
  TextEditingController partialAnsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<Image> images = [];
  UsersModel user = UsersModel(id: '', name: '', email: '');

  void loadImages() async {
    for (final id in widget.problem.imgIds) {
      images.add(Image.network(await ImgManager.getImage(id)));
    }
    setState(() {});
  }

  void loadUser() async {
    user = await AccountManager.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadImages();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: Design.spacing,
        children: [
          Container(
              width: double.infinity,
              padding: Design.spacing,
              decoration: const BoxDecoration(
                color: Design.insideColor,
                borderRadius: Design.outsideBorderRadius,
              ),
              child: Text(widget.problem.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center)),
          const SizedBox(height: 10),
          Container(
            padding: Design.spacing,
            decoration: const BoxDecoration(
              color: Design.insideColor,
              borderRadius: Design.outsideBorderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: Text('題目文字內容', style: TextStyle(fontSize: 20))),
                Text(widget.problem.description,
                    style: const TextStyle(fontSize: 17)),
                for (final image in images)
                  Container(padding: const EdgeInsets.all(10), child: image),
              ],
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: partialAnsController,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              hintText: '提供的部分答案與應徵文...',
              hintStyle: const TextStyle(
                  color: Design.secondaryTextColor, fontSize: 20),
              filled: true,
              fillColor: Design.insideColor,
              contentPadding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Design.insideColor),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Design.insideColor),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Design.insideColor),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "此欄位不可空白";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: priceController,
            textInputAction: TextInputAction.newline,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            maxLines: 1,
            decoration: InputDecoration(
              hintText: '應徵價格 (底價NT\$${widget.problem.baseToken})',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
              filled: true,
              fillColor: Design.insideColor,
              contentPadding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              isDense: true,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty || int.parse(value) < widget.problem.baseToken) {
                return "請輸入比底價高的價格";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Container(
            padding: Design.spacing,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Design.insideColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${dateTime.year}/${dateTime.month}/${dateTime.day}',
                    style: const TextStyle(fontSize: 20)),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(FeatherIcons.calendar),
                  onPressed: () async {
                    final date = await pickDate();
                    if (date == null) return; // Press cancal
                    setState(() => dateTime = date); // Press OK
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          ConfirmButtom(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                addCommand();
                DialogManager.showInfoDialog(context, '應徵成功', onOk: () {
                  Navigator.pop(context);
                });
              }
            },
            name: '應徵',
          ),
        ],
      ),
    );
  }

  void addCommand() async {
    final price = int.parse(priceController.text);
    final partialAns = partialAnsController.text;
    final deadline = dateTime;
    final userId = user.id;
    final contract = ContractsModel(
      id: '',
      price: price,
      partialAns: partialAns,
      deadline: deadline,
      solverId: userId,
    );
    final contractId = await ContractsDatabase.addContract(contract);
    widget.problem.solveCommendIds.add(contractId);
    ProblemsDatabase.updateProblem(widget.problem);

    final author = await UsersDatabase.queryUser(widget.problem.authorId);
    author.notices.add("您的問題${widget.problem.title}有人應徵了!!");
    UsersDatabase.updateUser(author);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: currentTime,
        firstDate: currentTime,
        lastDate:
            DateTime(currentTime.year, currentTime.month, currentTime.day + 7),
      );
}
