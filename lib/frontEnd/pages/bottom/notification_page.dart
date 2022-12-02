import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/buttom_navigation_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const NotificationPageBody(),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.notificationPage),
      ),
    );
  }
}

class NotificationPageBody extends StatefulWidget {
  const NotificationPageBody({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationPageBody> createState() => _NotificationPageBodyState();
}

class _NotificationPageBodyState extends State<NotificationPageBody> {
  var user = UsersModel(id: '', name: '', email: '');

  Future<void> loadUserInfo() async {
    user = await AccountManager.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: Design.spacing,
      children: [
        for (final notice in user.notices)
          Container(
            padding: Design.spacing,
            width: double.infinity,
            child: Row(
              children: [
                const Icon(
                  Icons.notifications,
                  color: Design.primaryColor,
                ),
                Text(
                  notice,
                  style: const TextStyle(
                      color: Design.secondaryTextColor, fontSize: 16),
                  maxLines: 3,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
