import 'package:flutter/material.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/main/buttom_navigation_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Design.backgroundColor),
      backgroundColor: Design.secondaryColor,
      body: const NotificationPageBody(),
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex:
            Routes.bottomNavigationRoutes.indexOf(Routes.notificationPage)
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
  var user = UsersModel();

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
    List<Widget> notifications = [];
    for (final notice in user.notices.reversed) {
      notifications.add(NotificationCard(
        notice: notice,
      ));
      notifications.add(const SizedBox(height: 10));
    }

    return ListView(
      padding: Design.spacing,
      children: notifications,
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.notice,
  }) : super(key: key);

  final String notice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Design.insideColor,
        borderRadius: Design.outsideBorderRadius,
      ),
      padding: Design.spacing,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Design.secondaryColor,
            child: Icon(
              size: 30,
              Icons.notifications_none_outlined,
              color: Design.primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              notice,
              style: const TextStyle(
                  color: Design.secondaryTextColor, fontSize: 15),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
