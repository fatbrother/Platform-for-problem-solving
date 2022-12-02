import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});
  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  List<FeedbacksModel> feedbacks = [];
  int starNum = 6;

  Future<void> loadFeedbacks() async {
    UsersModel user = await AccountManager.currentUser;
    feedbacks = user.feedbacks;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SimpleAppBar(),
        backgroundColor: Design.backgroundColor,
        body: Container(
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
                  LittleSwitch(
                    isOn: starNum == 6,
                    onChanged: () {
                      setState(() {
                        starNum = 6;
                      });
                    },
                    children: [
                      Text('全部',
                          style: TextStyle(
                              color: starNum == 6
                                  ? Colors.white
                                  : Design.primaryTextColor))
                    ],
                  ),
                  for (int i = 5; i > 0; i--)
                    LittleSwitch(
                      isOn: i == starNum,
                      onChanged: () {
                        setState(() {
                          starNum = i;
                        });
                      },
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
                    for (final feedback in feedbacks)
                      if (feedback.score == starNum || starNum == 6)
                        RateBox(
                          feedback: feedback,
                        ),
                  ],
                ),
              ),
            ],
          ),
        ));
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

class LittleSwitch extends StatelessWidget {
  final bool isOn;
  final Function() onChanged;
  final List<Widget> children;

  const LittleSwitch({
    super.key,
    required this.isOn,
    required this.onChanged,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Design.getScreenWidth(context) * 0.135,
      height: Design.getScreenHeight(context) * 0.04,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: isOn ? Design.primaryColor : Design.insideColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: Design.outsideBorderRadius,
          ),
        ),
        onPressed: onChanged,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
