import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/main/scaffold.dart';
import 'package:pops/widgets/other/setting_bar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: const SettingBody(),
      backgroundColor: Design.secondaryColor,
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }
}

class SettingBody extends StatefulWidget {
  const SettingBody({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  String version = '0.0.0';
  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version == '' ? '0.0.0' : packageInfo.version;
    setState(() {});
  }

  @override
  void initState() {
    getVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: Design.spacing,
      children: [
        SettingBar(
            onPressed: () => Routes.push(context, Routes.accountSettingPage),
            name: '帳號管理'),
        const SizedBox(height: 10),
        Container(
            padding: Design.spacing,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: Design.outsideBorderRadius,
              color: Design.insideColor,
            ),
            child: Column(
              children: [
                const Text('版本',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
                Text(version,
                    style: const TextStyle(color: Colors.black, fontSize: 20)),
              ],
            )),
      ],
    );
  }
}
