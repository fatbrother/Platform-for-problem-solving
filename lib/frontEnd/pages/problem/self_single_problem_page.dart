import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/tag.dart';

class SelfSinglefProblemPage extends StatefulWidget {
  final ProblemsModel problem;

  const SelfSinglefProblemPage({super.key, required this.problem});
  @override
  State<StatefulWidget> createState() => _SelfSinglefProblemPage();
}

class _SelfSinglefProblemPage extends State<SelfSinglefProblemPage> {
  List<WidgetBuilder> applicationBoxList = [
    (context) => const ApplicationBox()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SimpleAppBar(),
        backgroundColor: Design.backgroundColor,
        body: SingleProblemPageBody(applicationBoxList: applicationBoxList));
  }
}

class SingleProblemPageBody extends StatelessWidget {
  const SingleProblemPageBody({
    Key? key,
    required this.applicationBoxList,
  }) : super(key: key);

  final List<WidgetBuilder> applicationBoxList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: Design.spacing,
      child: Container(
        decoration: const BoxDecoration(
            color: Design.secondaryColor,
            borderRadius: Design.outsideBorderRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: Design.spacing,
                children: applicationBoxList
                    .map((WidgetBuilder applicationBox) =>
                        applicationBox(context))
                    .toList(),
              ),
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        DialogManager.showContentDialog(
                          context,
                          const Text('刪除後不會歸還上架金額！'),
                          () {},
                        );
                      },
                      icon: const Icon(Icons.delete)),
                  IconButton(
                      onPressed: () {
                        DialogManager.showContentDialog(
                          context,
                          const Text('加價15代幣以增加平台推廣'),
                          () {},
                        );
                      },
                      icon: const Icon(Icons.monetization_on_outlined)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ApplicationBox extends StatelessWidget {
  const ApplicationBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            // Routes.push(context, Routes.applicationProfile);
          },
          child: Container(
            padding: Design.spacing,
            decoration: const BoxDecoration(
              borderRadius: Design.outsideBorderRadius,
              color: Design.insideColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    borderRadius: Design.outsideBorderRadius,
                    color: Design.secondaryColor,
                  ),
                  child: const Text(
                    'name',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Icon(Icons.attach_money),
                    Text('price'),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: const [
                    Icon(Icons.discount_outlined),
                    ShowTagsWidget(title: '123', isGeneral: true),
                    ShowTagsWidget(title: '123', isGeneral: true),
                    ShowTagsWidget(title: '123', isGeneral: false),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
