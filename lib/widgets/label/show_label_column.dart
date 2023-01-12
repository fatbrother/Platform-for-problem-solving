import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';

class ShowLabelColumn extends StatelessWidget {
  const ShowLabelColumn({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final String title;

  @override
  Widget build(BuildContext context) {
    // add sizebox between child of children
    List<Widget> childrenWithSizeBox = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      childrenWithSizeBox.add(children[i]);
      if (i != children.length - 1) {
        childrenWithSizeBox
            .add(SizedBox(height: Design.getScreenHeight(context) * 0.02));
      }
    }

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Design.getScreenHeight(context) * 0.1,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(
        borderRadius: Design.outsideBorderRadius,
        color: Color.fromARGB(136, 160, 182, 195),
      ),
      child: Column(
        children: [
          //標題
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Design.primaryTextColor,
            ),
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          for (final child in childrenWithSizeBox) child,
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }
}
