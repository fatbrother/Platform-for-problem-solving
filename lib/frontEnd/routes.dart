// When we are adding a new page, we need to add it to the routes map.

import 'package:flutter/cupertino.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/frontEnd/pages/setting/general_labels_page.dart';
import 'package:pops/frontEnd/pages/home_page.dart';
import 'package:pops/frontEnd/pages/add_probelm_page.dart';
import 'package:pops/frontEnd/pages/audit_failed_lables_page.dart';
import 'package:pops/frontEnd/pages/setting/identification_page.dart';
import 'package:pops/frontEnd/pages/init/login_page.dart';
import 'package:pops/frontEnd/pages/init/register_page.dart';
import 'package:pops/frontEnd/pages/question_appilcation_page.dart';
import 'package:pops/frontEnd/pages/report/report_fail_page.dart';
import 'package:pops/frontEnd/pages/report/report_page.dart';
import 'package:pops/frontEnd/pages/report/report_success_page.dart';
import 'package:pops/frontEnd/pages/setting/account_setting_page.dart';
import 'package:pops/frontEnd/pages/user/add_label_page.dart';
import 'package:pops/frontEnd/pages/user/setting_page.dart';
import 'package:pops/frontEnd/pages/user/self_information_page.dart';
import 'package:pops/frontEnd/pages/self_problem_page.dart';
import 'package:pops/frontEnd/pages/self_single_problem_page.dart';
import 'package:pops/frontEnd/pages/setting/change_password_page.dart';
import 'package:pops/frontEnd/pages/setting/change_phone_number_page.dart';
import 'package:pops/frontEnd/pages/setting/system_labels_page.dart';
import 'package:pops/frontEnd/pages/user/top_up_page.dart';
import 'package:pops/frontEnd/pages/chatroom_page.dart';

import 'pages/user/common_problems_page.dart';
// import '../backEnd/user/account.dart';
// import pages here
// import 'pages/[page file name].dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyPhone = '/verifyPhone';

  static const String selfProblemPage = '/selfProblemPage';
  static const String selfSingleProblemPage = '/selfSingleProblemPage';
  static const String identificationPage = '/identificationPage';

  static const String selfInformationPage = '/selfInformationPage';
  static const String topUpPage = '/topUpPage';
  static const String commonProblemPage = '/commonProblemPage';
  static const String settingPage = '/settingPage';
  static const String addLabelPage = '/addLabelPage';

  static const String accountSettingPage = '/accountSettingPage';
  static const String generalLabelsPage = '/generalLabelsPage';
  static const String systemLabelsPage = '/systemLabelsPage';

  static const String changePasswordPage = '/changePasswordPage';
  static const String changePhoneNumberPage = '/changePhoneNumberPage';
  static const String auditFailedTagsPage = '/auditFailedTagsPage';

  static const String ratingPage = '/ratingPage';
  static const String reportPage = '/reportPage';
  static const String reportFailPage = '/reportFailPage';
  static const String reportSuccessPage = '/reportSuccessPage';

  static const String ratePage = '/ratePage';

  static const String homePage = '/homePage';
  static const String questionApplyPage = '/questionApplyPage';
  static const String addProblemPage = '/addProblemPage';
  static const String chatroomPage = '/chatroomPage';

  static Widget Function(BuildContext context)? get homeRoute =>
      Routes()._routes[homeRouteName];

  static String get homeRouteName =>
      AccountManager.isLoggedIn() ? homePage : login;

  static Map<String, WidgetBuilder> get routes => Routes()._routes;

  // add routes here
  // static const String [route name] = '/[route name]';

  final Map<String, WidgetBuilder> _routes = {
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    //userTagPage: (context) => const UserTagPage(),
    auditFailedTagsPage: (context) => const AuditFailedTagsPage(),
    selfProblemPage: (context) => const SelfProblemPage(),
    changePasswordPage: (context) => const ChangePasswordPage(),
    changePhoneNumberPage: (context) => const ChangePhoneNumberPage(),
    ratingPage: (context) => const RatingPage(),
    identificationPage: (context) => const IdentificationPage(),
    topUpPage: (context) => const TopUpPage(),
    reportPage: (context) => const ReportPage(),
    ratePage: (context) => const RatePage(),
    reportFailPage: (context) => const ReportFailPage(),
    reportSuccessPage: (context) => const ReportSuccessPage(),
    homePage: (context) => const HomePage(),
    questionApplyPage: (context) => const QuestionApplyPage(),
    addProblemPage: (context) => AddProblemPage(),
    commonProblemPage: (context) => const CommonProblemPage(),
    settingPage: (context) => const SettingPage(),
    accountSettingPage: (context) => const AccountSettingPage(),
    addLabelPage: (context) => const AddLabelPage(),
    generalLabelsPage: (context) => const GeneralLabelsPage(),
    systemLabelsPage: (context) => const SystemLabelsPage(),
    chatroomPage: (context) => const Chatroom(),
    // add routes here
    // [route name]: (context) => const [page name](),

    // wideget builder for the single problem page
    selfSingleProblemPage: (context) {
      final ProblemsModel problem =
          ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return SelSinglefProblemPage(problem: problem);
    },

    selfInformationPage: (context) => const SelfInformationPage(),
  };

  static List<String> bottomNavigationRoutes = [
    homePage,
    '',
    selfProblemPage,
    '',
    '',
    selfInformationPage,
  ];

  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void push(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }
}
