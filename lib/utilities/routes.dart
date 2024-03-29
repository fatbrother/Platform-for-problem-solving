// When we are adding a new page, we need to add it to the routes map.
import 'package:flutter/cupertino.dart';
import 'package:pops/screens/bottom/base.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/screens/bottom/home_page.dart';
import 'package:pops/screens/bottom/notification_page.dart';
import 'package:pops/screens/bottom/self_information_page.dart';
import 'package:pops/screens/bottom/self_problem_page.dart';
import 'package:pops/screens/bottom/sort_problem_page.dart';
import 'package:pops/screens/bottom/unsolved_problem_page.dart';
import 'package:pops/screens/init/login_page.dart';
import 'package:pops/screens/init/register_page.dart';
import 'package:pops/screens/problem/add_probelm_page.dart';
import 'package:pops/screens/problem/answer_page.dart';
import 'package:pops/screens/problem/application_profile.dart';
import 'package:pops/screens/problem/question_apply_page.dart';
import 'package:pops/screens/problem/rating_page.dart';
import 'package:pops/screens/problem/self_single_problem_page.dart';
import 'package:pops/screens/problem/upload_ans_page.dart';
import 'package:pops/screens/report/report_fail_page.dart';
import 'package:pops/screens/report/report_page.dart';
import 'package:pops/screens/report/report_success_page.dart';
import 'package:pops/screens/report/report_wait_page.dart';
import 'package:pops/screens/setting/account_setting_page.dart';
import 'package:pops/screens/setting/change_password_page.dart';
import 'package:pops/screens/setting/general_labels_page.dart';
import 'package:pops/screens/setting/system_labels_page.dart';
import 'package:pops/screens/user/add_label_page.dart';
import 'package:pops/screens/user/chatroom_page.dart';
import 'package:pops/screens/user/files_page.dart';
import 'package:pops/screens/user/rate_page.dart';
import 'package:pops/screens/user/setting_page.dart';
import 'package:pops/screens/user/top_up_page.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/report_model.dart';
import 'package:pops/models/user_model.dart';

class Routes {
  static const String baseMainPage = '/baseMainPage';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyPhone = '/verifyPhone';
  static const String selfProblemPage = '/selfProblemPage';
  static const String selfSingleProblemPage = '/selfSingleProblemPage';
  static const String selfInformationPage = '/selfInformationPage';
  static const String topUpPage = '/topUpPage';
  static const String commonProblemPage = '/commonProblemPage';
  static const String settingPage = '/settingPage';
  static const String addLabelPage = '/addLabelPage';
  static const String notificationPage = '/notificationPage';
  static const String sortProblemPage = '/sortProblemPage';
  static const String folderPage = '/folderPage';
  static const String accountSettingPage = '/accountSettingPage';
  static const String generalLabelsPage = '/generalLabelsPage';
  static const String systemLabelsPage = '/systemLabelsPage';
  static const String changePasswordPage = '/changePasswordPage';
  static const String auditFailedlabelsPage = '/auditFailedlabelsPage';
  static const String ratingPage = '/ratingPage';
  static const String reportPage = '/reportPage';
  static const String reportWaitPage = '/reportWaitPage';
  static const String reportFailPage = '/reportFailPage';
  static const String reportSuccessPage = '/reportSuccessPage';
  static const String ratePage = '/ratePage';
  static const String applicationProfilePage = '/applicationProfilePage';
  static const String homePage = '/homePage';
  static const String questionApplyPage = '/questionApplyPage';
  static const String addProblemPage = '/addProblemPage';
  static const String chatRoomPage = '/chatRoomPage';
  static const String unsolvedPage = '/unsolnedPage';
  static const String uploadAnsPage = '/uploadAnsPage';
  static const String answerPage = '/answerPage';
  static const List<String> bottomNavigationRoutes = [
    homePage,
    unsolvedPage,
    selfProblemPage,
    notificationPage,
    sortProblemPage,
    selfInformationPage,
  ];

  static Widget Function(BuildContext context)? get homeRoute =>
      Routes()._routes[homeRouteName];

  static String get homeRouteName =>
      AccountManager.isLoggedIn() ? baseMainPage : login;

  static Map<String, WidgetBuilder> get routes => Routes()._routes;

  final Map<String, WidgetBuilder> _routes = {
    baseMainPage: (context) => const BaseMainPage(),
    login: (context) => const LoginPage(),
    register: (context) => const RegisterPage(),
    selfProblemPage: (context) => const SelfProblemPage(),
    changePasswordPage: (context) => const ChangePasswordPage(),
    notificationPage: (context) => const NotificationPage(),
    topUpPage: (context) => const TopUpPage(),
    reportFailPage: (context) => const ReportFailPage(),
    homePage: (context) => const HomePage(),
    addProblemPage: (context) => const AddProblemPage(),
    settingPage: (context) => const SettingPage(),
    accountSettingPage: (context) => const AccountSettingPage(),
    addLabelPage: (context) => const AddLabelPage(),
    generalLabelsPage: (context) => const GeneralLabelsPage(),
    systemLabelsPage: (context) => const SystemLabelsPage(),
    unsolvedPage: (context) => const UnsolvedPage(),
    sortProblemPage: (context) => const SortProblemPage(),
    selfInformationPage: (context) => const SelfInformationPage(),
    ratePage: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as UsersModel;
      return RatePage(user: args);
    },
    reportSuccessPage: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as ReportsModel;
      return ReportSuccessPage(report: args);
    },
    reportWaitPage: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return ReportWaitPage(reportId: args);
    },
    reportPage: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return ReportPage(problem: args);
    },
    ratingPage: (context) {
      final ProblemsModel args =
          ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return RatingPage(problem: args);
    },
    answerPage: (context) {
      final ProblemsModel args =
          ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return AnswerPage(problem: args);
    },
    uploadAnsPage: (context) {
      final ProblemsModel args =
          ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return UploadAnsPage(problem: args);
    },
    applicationProfilePage: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      return ApplicationProfilePage(
        solver: args['user'],
        contract: args['contract'],
        problem: args['problem'],
      );
    },
    folderPage: (context) {
      final FolderModel args =
          ModalRoute.of(context)!.settings.arguments as FolderModel;
      return FilesPage(folder: args);
    },
    chatRoomPage: (context) {
      Map args = ModalRoute.of(context)!.settings.arguments as Map;
      return ChatRoomPage(
        chatRoomId: args['chatRoomId'],
        canEdit: args.containsKey('canEdit') ? args['canEdit'] : false,
      );
    },
    selfSingleProblemPage: (context) {
      final ProblemsModel args =
          ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return SelfSinglefProblemPage(problem: args);
    },
    questionApplyPage: (context) {
      final ProblemsModel args =
          ModalRoute.of(context)!.settings.arguments as ProblemsModel;
      return QuestionApplyPage(problem: args);
    },
  };

  static void back(BuildContext context) {
    Navigator.pop(context);
  }

  static void push(BuildContext context, String routeName,
      {Object? arguments, Function? onPop}) {
    Navigator.pushNamed(context, routeName, arguments: arguments).then((_) {
      if (onPop != null) {
        onPop();
      }
    });
  }

  static void pushReplacement(BuildContext context, String routeName,
      {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false,
        arguments: arguments);
  }
}
