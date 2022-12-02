import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';
import 'package:pops/frontEnd/widgets/suggest_field.dart';
import 'package:pops/frontEnd/widgets/star_plate.dart';
import 'package:pops/frontEnd/routes.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({super.key});
  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  var numOfStars = 0;
  TextEditingController ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Design.backgroundColor,
        body: Container(
          margin: Design.spacing,
          padding: Design.spacing,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Design.getScreenHeight(context) * 0.025),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => {Routes.back(context)},
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 35,
                    ),
                  ],
                ),
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
                    onPressed: () =>
                        {DialogManager.showInfoDialog(context, '感謝您的評分！')},
                    text: '送出'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
