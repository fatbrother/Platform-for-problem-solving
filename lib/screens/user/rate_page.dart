import 'package:flutter/material.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/widgets/main/app_bar.dart';
import 'package:pops/widgets/select_button.dart';

class RatePage extends StatelessWidget {
  final UsersModel user;

  const RatePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GoBackBar(),
      backgroundColor: Design.backgroundColor,
      body: RateBody(feedbacks: user.feedbacks),
    );
  }
}

class RateBody extends StatefulWidget {
  final List<FeedbacksModel> feedbacks;

  const RateBody({super.key, required this.feedbacks});

  @override
  State<RateBody> createState() => _RateBodyState();
}

class _RateBodyState extends State<RateBody> {
  int starNum = 6;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      decoration: const BoxDecoration(
        color: Design.secondaryColor,
        borderRadius: Design.insideBorderRadius,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SelectButton(
                isOn: starNum == 6,
                onChanged: () => setState(() {
                  starNum = 6;
                }),
                children: [
                  Text('全部',
                      style: TextStyle(
                          color: starNum == 6
                              ? Colors.white
                              : Design.primaryTextColor))
                ],
              ),
              for (int i = 5; i > 0; i--)
                SelectButton(
                  isOn: i == starNum,
                  onChanged: () => setState(() {
                    starNum = i;
                  }),
                  children: [
                    Text('$i',
                        style: TextStyle(
                          color: i == starNum
                              ? Colors.white
                              : Design.primaryTextColor,
                        )),
                    Icon(Icons.star_border_rounded,
                        color: i == starNum
                            ? Colors.white
                            : Design.primaryTextColor),
                  ],
                ),
            ],
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.02),
          Expanded(
            child: ListView(
              children: [
                for (final feedback in widget.feedbacks)
                  if (feedback.score == starNum || starNum == 6)
                    RateBox(
                      feedback: feedback,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RateBox extends StatelessWidget {
  final FeedbacksModel feedback;

  const RateBox({
    super.key,
    required this.feedback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: Design.outsideBorderRadius,
        color: Design.insideColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                feedback.userName,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              for (int i = 0; i < feedback.score; i++)
                const Icon(
                  Icons.star,
                ),
            ],
          ),
          Text(
            feedback.feedback,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          )
        ],
      ),
    );
  }
}
