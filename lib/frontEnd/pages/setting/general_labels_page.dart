import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/scaffold.dart';

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
      body: Container(),
      currentIndex: Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}