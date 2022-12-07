import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/contract.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/routes.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/suggest_field.dart';
import 'package:pops/frontEnd/widgets/star_plate.dart';

class RatingPage extends StatefulWidget {
  final ProblemsModel problem;

  const RatingPage({super.key, required this.problem});
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  var numOfStars = 0;
  TextEditingController ratingController = TextEditingController();
  UsersModel ratingUser = UsersModel(id: '', name: '', email: '');
  UsersModel currentUser = UsersModel(id: '', name: '', email: '');
  ContractsModel contract = ContractsModel();

  Future<void> loadUser() async {
    contract = await ContractsDatabase.queryContract(widget.problem.chooseSolveCommendId);
    ratingUser = await UsersDatabase.queryUser(contract.solverId);
    currentUser = await AccountManager.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const SimpleAppBar(),
        backgroundColor: Design.backgroundColor,
        body: Container(
          padding: Design.spacing,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  '請給予解題者評分評語',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Design.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.03),
                StarPlate(
                  numOfStars: numOfStars,
                  radius: 0.28 * Design.getScreenWidth(context),
                  onPressed: () => setState(() {
                    numOfStars++;
                    numOfStars %= 6;
                  }),
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.02),
                SuggestField(
                  maxline: 14,
                  hintTextFloating: '輸入評語...',
                  controller: ratingController,
                ),
                SizedBox(height: Design.getScreenHeight(context) * 0.02),
                SendButton(
                    onPressed: () {
                      if (ratingController.text == '') {
                        DialogManager.showInfoDialog(context, '請輸入評語');
                        return;
                      }
                      FeedbacksModel feedback = FeedbacksModel(
                        userName: currentUser.name,
                        feedback: ratingController.text,
                        score: numOfStars,
                      );
                      ratingUser.feedbacks.add(feedback);
                      ratingUser.score += numOfStars;
                      ratingUser.numberOfScores++;
                      ratingUser.notices.add("您的${widget.problem.title}解題已被評分，${widget.problem.rewardToken}\$已經匯入您的錢包");
                      ratingUser.commandProblemIds.remove(widget.problem.id);
                      ratingUser.tokens += widget.problem.rewardToken;
                      UsersDatabase.updateUser(ratingUser);
                      widget.problem.isSolved = true;
                      ProblemsDatabase.updateProblem(widget.problem);
                      DialogManager.showInfoDialog(context, '感謝您的評分！');
                      Routes.pushReplacement(context, Routes.homePage);
                    },
                    text: '送出'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
