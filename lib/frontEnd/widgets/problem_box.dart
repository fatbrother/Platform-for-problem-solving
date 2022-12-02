import 'package:flutter/material.dart';
import 'package:pops/backEnd/problem/problem.dart';
import 'package:pops/frontEnd/design.dart';

class ProbelmBoxIcon extends StatelessWidget {
  final ProblemsModel problem;
  final void Function() onTap;

  const ProbelmBoxIcon({
    super.key,
    required this.problem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 3.0,
                    ),
                    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: const BoxDecoration(
                      borderRadius: Design.outsideBorderRadius,
                      color: Design.secondaryColor,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        problem.title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            right: 15, left: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const ImageIcon(
                              AssetImage('assets/icon/users.png'),
                              color: Colors.black,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              problem.authorName,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 20, top: 10, bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.access_time_rounded),
                            const SizedBox(width: 10),
                            Text(
                              problem.existTimeString,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}
