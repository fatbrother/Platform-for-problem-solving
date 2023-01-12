import 'package:flutter/material.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/widgets/label/label.dart';

class ShowlabelsWidget extends StatelessWidget {
  final String title;
  final List<String> labels;
  final bool isGeneral;
  final Function(String) onLongPress;

  const ShowlabelsWidget({
    super.key,
    required this.title,
    required this.labels,
    required this.isGeneral,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Design.insideColor),
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Design.getScreenHeight(context) * 0.15,
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
          Wrap(
              spacing: 5,
              runSpacing: 5,
              direction: Axis.horizontal,
              children: [
                for (final labels in labels)
                  GestureDetector(
                    onLongPress: () => onLongPress(labels),
                    child: ShowLabelWidget(
                      title: labels,
                      isGeneral: isGeneral,
                    ),
                  ),
              ]),
          SizedBox(height: Design.getScreenHeight(context) * 0.01),
        ],
      ),
    );
  }
}
