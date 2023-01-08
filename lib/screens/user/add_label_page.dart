import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/scaffold.dart';
import 'package:pops/widgets/setting_bar.dart';

class AddLabelPage extends StatelessWidget {
  const AddLabelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      backgroundColor: Design.secondaryColor,
      body: ListView(
        padding: Design.spacing,
        children: <Widget>[
          SettingBar(
            name: "專業標籤",
            onPressed: () => Routes.push(context, Routes.generalLabelsPage),
          ),
          const SizedBox(height: 10),
          SettingBar(
            name: "系統標籤",
            onPressed: () => Routes.push(context, Routes.systemLabelsPage),
          ),
        ],
      ),
      currentIndex: Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}