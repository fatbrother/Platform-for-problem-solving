import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/scaffold.dart';
import 'package:pops/widgets/setting_bar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String version = '0.0.0';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: ListView(
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
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20)),
                ],
              )),
        ],
      ),
      backgroundColor: Design.secondaryColor,
      currentIndex:
          Routes.bottomNavigationRoutes.indexOf(Routes.selfInformationPage),
    );
  }

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
}