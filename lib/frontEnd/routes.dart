// When we are adding a new page, we need to add it to the routes map.

import 'package:flutter/cupertino.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/pages/change_password_page.dart';
import 'package:pops/frontEnd/pages/change_phone_number_page.dart';
import 'package:pops/frontEnd/pages/general_labels_page.dart';
import 'package:pops/frontEnd/pages/login_page.dart';
import 'package:pops/frontEnd/pages/problem_page.dart';
import 'package:pops/frontEnd/pages/rating_page.dart';
import 'package:pops/frontEnd/pages/register_page.dart';
import 'package:pops/frontEnd/pages/single_problem_page.dart';
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
  static const String problemPage = '/problemPage';
  static const String singleProblemPage = '/singleProblemPage';
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
    problemPage: (context) => const ProblemPage(),
    changePasswordPage: (context) => const ChangePasswordPage(),
    changePhoneNumberPage: (context) => const ChangePhoneNumberPage(),
    ratingPage: (context) => const RatingPage(),
    // add routes here
    // [route name]: (context) => const [page name](),


    // wideget builder for the single problem page
    singleProblemPage: (context) {
      final ProblemsModel problem = ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return SingleProblemPage(problem: problem);
    },
    
  };

  static Map<String, WidgetBuilder> get routes => Routes()._routes;

  static Widget Function(BuildContext context)? get homeRoute =>
      AccountManager.isLoggedIn()
          ? Routes.routes[Routes.problemPage]
          : Routes.routes[Routes.login];
}
