import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowTagsWidget extends StatelessWidget {
  final String title;
  const ShowTagsWidget({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(children: <Widget>[
        SvgPicture.asset(
          'assets/label_left_triangle.svg',
          color: const Color.fromARGB(255, 208, 171, 204),
        ),
        Container(
            height: 24.2,
            padding: const EdgeInsets.symmetric(horizontal: 3.4, vertical: 3.1),
            color: const Color.fromARGB(255, 208, 171, 204),
            child: Container(
              //alignment: Alignment.center, <--用了的話container的長度就沒辦法hug text
              color: const Color.fromARGB(255, 255, 255, 255),
              // constraints: const BoxConstraints(
              //   maxWidth: 250,
              // ), //待調
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15),
              ),
            )),
      ]),
    );
  }
}
