import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/buttons.dart';
//import 'package:pops/frontEnd/widgets/enter_botton.dart';
import 'package:pops/frontEnd/widgets/suggest_field.dart';
import 'package:pops/frontEnd/widgets/star_plate.dart';

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
        resizeToAvoidBottomInset: true,
        backgroundColor: Design.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Design.getScreenHeight(context) * 0.05,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 40,
                  ),
                ],
              ),
              const Text(
                '請給予解題者評分評語',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Design.primaryColor,
                ),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Design.getScreenHeight(context) * 0.05,
              ),
              GestureDetector(
                child: Center(
                  child: CircleAvatar(
                    radius: 0.28 * Design.getScreenWidth(context),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    child: StarPlate(numOfStars: numOfStars, size: 200.0),
                  ),
                ),
                onTap: () => setState(
                  () {
                    numOfStars++;
                    numOfStars %= 6;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: SuggestField(
                  maxline: 15,
                  hintTextFloating: '輸入評語...',
                  controller: ratingController,
                ),
              ),
              SendButton(onPressed: () => {}, text: '送出'),
            ],
          ),
        ),
      ),
    );
  }
}
