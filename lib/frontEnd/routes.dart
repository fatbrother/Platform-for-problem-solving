// When we are adding a new page, we need to add it to the routes map.

import 'package:flutter/cupertino.dart';
import 'package:pops/frontEnd/pages/general_labels_page.dart';
import '../backEnd/user/account.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
// import pages here
// import 'pages/[page file name].dart';

class Routes {
  static const String home = '/index';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyPhone = '/verifyPhone';
  static const String tagPage = '/tagPage';
  // add routes here
  // static const String [route name] = '/[route name]';

  final Map<String, WidgetBuilder> _routes = {
    home: (context) => const HomePage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    tagPage: (context) => const TagPage(),
    // add routes here
    // [route name]: (context) => const [page name](),
  };

  static Map<String, WidgetBuilder> get routes => Routes()._routes;

  static Widget Function(BuildContext context)? get homeRoute =>
      AccountManager.isLoggedIn()
          ? Routes.routes[Routes.home]
          : Routes.routes[Routes.login];
  // static Widget Function(BuildContext context)? get homeRoute =>
  //     Routes.routes[Routes.tagPage];
}
