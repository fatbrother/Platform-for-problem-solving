// When we are adding a new page, we need to add it to the routes map.

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/pages/change_password_page.dart';
import 'package:pops/frontEnd/pages/change_phone_number_page.dart';
import 'package:pops/frontEnd/pages/general_labels_page.dart';
import 'package:pops/frontEnd/pages/login_page.dart';
import 'package:pops/frontEnd/pages/self_problem_page.dart';
import 'package:pops/frontEnd/pages/rating_page.dart';
import 'package:pops/frontEnd/pages/register_page.dart';
import 'package:pops/frontEnd/pages/self_single_problem_page.dart';
import 'package:pops/frontEnd/pages/system_labels_page.dart';
// import '../backEnd/user/account.dart';
// import pages here
// import 'pages/[page file name].dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyPhone = '/verifyPhone';
  static const String userTagPage = '/userTagPage';
  static const String systemTagPage = '/systemTagPage';
  static const String selfProblemPage = '/selfProblemPage';
  static const String selfSingleProblemPage = '/selfSingleProblemPage';
  static const String ratingPage = '/ratingPage';
  static const String changePasswordPage = '/changePasswordPage';
  static const String changePhoneNumberPage = '/changePhoneNumberPage';
  // add routes here
  // static const String [route name] = '/[route name]';

  final Map<String, WidgetBuilder> _routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    userTagPage: (context) => const UserTagPage(),
    systemTagPage: (context) => const SystemTagPage(),
    selfProblemPage: (context) => const SelfProblemPage(),
    changePasswordPage: (context) => const ChangePasswordPage(),
    changePhoneNumberPage: (context) => const ChangePhoneNumberPage(),
    ratingPage: (context) => const RatingPage(),
    // add routes here
    // [route name]: (context) => const [page name](),

    // wideget builder for the single problem page
    selfSingleProblemPage: (context) {
      final ProblemsModel problem =
          ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return SelSinglefProblemPage(problem: problem);
    },
  };

  static Map<String, WidgetBuilder> get routes => Routes()._routes;

  static String get homeRouteName =>
      AccountManager.isLoggedIn() ? selfProblemPage : login;

  static Widget Function(BuildContext context)? get homeRoute =>
      Routes()._routes[homeRouteName];

  static void push(BuildContext context, String routeName,
      {Object? arguments}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, routeName, arguments: arguments);
    });
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
    });
  }

  static void back(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
    });
  }
}
