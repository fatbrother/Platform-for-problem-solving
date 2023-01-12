import 'package:flutter/material.dart';
import 'package:pops/models/contract_model.dart';
import 'package:pops/models/problem_model.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/services/problem/contract.dart';
import 'package:pops/services/problem/problem.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/services/user/user.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/utilities/routes.dart';
import 'package:pops/widgets/main/app_bar.dart';
import 'package:pops/widgets/buttons.dart';
import 'package:pops/widgets/star_plate.dart';
import 'package:pops/widgets/suggest_field.dart';

class RatingPage extends StatefulWidget {
  final ProblemsModel problem;

  const RatingPage({super.key, required this.problem});
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  var numOfStars = 0;
  TextEditingController ratingController = TextEditingController();
  UsersModel ratingUser = UsersModel();
  UsersModel currentUser = UsersModel();

  Future<void> loadUser() async {
    ratingUser = await UsersDatabase.instance.query(widget.problem.solverId);
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
        appBar: const GoBackBar(),
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
                      UsersDatabase.instance.update(ratingUser);
                      widget.problem.isSolved = true;
                      ProblemsDatabase.instance.update(widget.problem);
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
