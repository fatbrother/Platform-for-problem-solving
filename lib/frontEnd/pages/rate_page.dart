import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';

class RatePage extends StatefulWidget {
  const RatePage({super.key});
  @override
  State<RatePage> createState() => _RatePageState();
}

class _RatePageState extends State<RatePage> {
  int starNum = 6;
  var starList = <int>[1, 5, 4, 3, 3, 2, 5, 3, 2, 4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.titleAppBar(title: 'Rate'),
      backgroundColor: Design.secondaryColor,
      body: Column(
        children: [
          SizedBox(height: Design.getScreenHeight(context) * 0.02),
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
          SizedBox(
            height: Design.getScreenHeight(context) * 0.792,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final star in starList)
                    if (star == starNum || starNum == 6) RateBox(rateNum: star),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RateBox extends StatelessWidget {
  final int rateNum;

  const RateBox({
    super.key,
    required this.rateNum,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Design.spacing,
      margin: Design.spacing,
      decoration: const BoxDecoration(
        borderRadius: Design.outsideBorderRadius,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'name',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              for (int i = 0; i < rateNum; i++)
                const Icon(
                  Icons.star,
                ),
            ],
          ),
          const Text(
            '評語',
            style: TextStyle(fontSize: 15, color: Colors.black),
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
