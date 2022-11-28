// When we are adding a new page, we need to add it to the routes map.

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/pages/audit_failed_tags_page.dart';
import 'package:pops/frontEnd/pages/change_password_page.dart';
import 'package:pops/frontEnd/pages/change_phone_number_page.dart';
import 'package:pops/frontEnd/pages/general_labels_page.dart';
import 'package:pops/frontEnd/pages/identification_page.dart';
import 'package:pops/frontEnd/pages/init/login_page.dart';
import 'package:pops/frontEnd/pages/report_page.dart';
import 'package:pops/frontEnd/pages/report_fail_page.dart';
import 'package:pops/frontEnd/pages/report_success_page.dart';
import 'package:pops/frontEnd/pages/self_problem_page.dart';
import 'package:pops/frontEnd/pages/rating_page.dart';
import 'package:pops/frontEnd/pages/init/register_page.dart';
import 'package:pops/frontEnd/pages/self_single_problem_page.dart';
import 'package:pops/frontEnd/pages/system_labels_page.dart';
import 'package:pops/frontEnd/pages/top_up_page.dart';
import 'package:pops/frontEnd/pages/self_information_page.dart';
import 'package:pops/frontEnd/pages/QuestionSearch(HomePage).dart';
import 'package:pops/frontEnd/pages/question_appilcation_page.dart';
import 'package:pops/frontEnd/pages/setting_page.dart';
import 'package:pops/frontEnd/pages/account_manage_page.dart';
// import '../backEnd/user/account.dart';
// import pages here
// import 'pages/[page file name].dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyPhone = '/verifyPhone';
  static const String topUp = '/topUp';

  static const String selfProblemPage = '/selfProblemPage';
  static const String selfSingleProblemPage = '/selfSingleProblemPage';
  static const String identificationPage = '/identificationPage';

  static const String userTagPage = '/userTagPage';
  static const String systemTagPage = '/systemTagPage';
  static const String changePasswordPage = '/changePasswordPage';
  static const String changePhoneNumberPage = '/changePhoneNumberPage';
  static const String auditFailedTagsPage = '/auditFailedTagsPage';

  //static const String ratingPage = '/ratingPage';
  static const String reportPage = '/reportPage';
  static const String reportFailPage = '/reportFailPage';
  static const String reportSuccessPage = '/reportSuccessPage';
  static const String selfInformationPage = '/selfInformationPage';

  static const String homePage = '/homePage';
  static const String questionApplyPage = '/questionApplyPage';
  static const String settingPage = '/settingPage';
  static const String accountManagePage = 'accountManagerPage';
  // add routes here
  // static const String [route name] = '/[route name]';

  final Map<String, WidgetBuilder> _routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    //userTagPage: (context) => const UserTagPage(),
    //systemTagPage: (context) => const SystemTagPage(),
    auditFailedTagsPage: (context) => const AuditFailedTagsPage(),
    selfProblemPage: (context) => const SelfProblemPage(),
    changePasswordPage: (context) => const ChangePasswordPage(),
    changePhoneNumberPage: (context) => const ChangePhoneNumberPage(),
    // ratingPage: (context) => const RatingPage(),
    identificationPage: (context) => const IdentificationPage(),
    topUp: (context) => const TopUpPage(),
    reportPage: (context) => const ReportPage(),
    reportFailPage: (context) => const ReportFailPage(),
    reportSuccessPage: (context) => const ReportSuccessPage(),
    homePage: (context) => const HomePage(),
    settingPage: (context) => const SettingPage(),
    questionApplyPage: (context) => QuestionApplyPage(),
    accountManagePage: (context) => AccountManagePage(),
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
      AccountManager.isLoggedIn() ? accountManagePage : login;

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
