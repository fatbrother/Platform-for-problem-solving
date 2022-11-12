import 'package:flutter/material.dart';
import 'package:pops/frontEnd/widgets/tag.dart';

class TagPage extends StatelessWidget {
  const TagPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(198, 192, 220, 236),
      appBar: AppBar(
        //build arrow_back
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color.fromARGB(255, 0, 0, 0),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            );
          },
        ),
        //AppBar color and word
        backgroundColor: const Color.fromARGB(222, 255, 255, 255),
        title: const Text('一般標籤',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        centerTitle: true,
      ),
      body: const GeneralLabelsView(),
    );
  }
}

class GeneralLabelsView extends StatefulWidget {
  const GeneralLabelsView({super.key});

  @override
  State<GeneralLabelsView> createState() => _GeneralLabelsViewState();
}

class _GeneralLabelsViewState extends State<GeneralLabelsView> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _tags = <String>[];
  final List<String> _usedTags = <String>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
      child: Column(
        children: [
          ShowCurrentTagsWidget(tags: _tags),
          const SizedBox(height: 19),
          ShowUsedTagsWidget(tags: _usedTags),
          const SizedBox(height: 19),
          //AddNewLabelText:59~96
          SizedBox(
            height: 35,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 12, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _textController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: '新增標籤',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Align(
                  alignment: const Alignment(1, 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          _tags.add(_textController.text);
                          _textController.clear();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 19),
          const InstructionsWiget(),
        ],
      ),
    );
  }
}

class ShowCurrentTagsWidget extends StatelessWidget {
  final List<String> tags;
  const ShowCurrentTagsWidget({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color.fromARGB(
              255, 255, 255, 255), //color沒放在decoration裡的話會overflow
        ),
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              '目前顯示的專業標籤',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 5,
            ),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              direction: Axis.horizontal,
              children: [
                for (final tag in tags) ShowTagsWidget(title: tag),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ));
  }
}

class ShowUsedTagsWidget extends StatelessWidget {
  final List<String> tags;

  const ShowUsedTagsWidget({super.key, required this.tags});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color.fromARGB(
            255, 255, 255, 255), //color沒放在decoration裡的話會overflow
      ),
      height: 100,
      width: double.infinity,
      child: Column(children: [
        const Text(
          '曾使用過的專業標籤',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            direction: Axis.vertical,
            children: [
              for (final tag in tags) ShowTagsWidget(title: tag),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ]),
    );
  }
}

//24.2, 18
//const Color.fromARGB(255, 240, 235, 116),系統認證標籤顏色

//說明頁面按鈕
class InstructionsWiget extends StatelessWidget {
  const InstructionsWiget({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: InkWell(
        onTap: () {
          //-->說明頁面
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePhoneNumberPage()));
        },
        child: Stack(children: <Widget>[
          Container(
            //padding: EdgeInsets.fromLTRB(2, 15, 2, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            alignment: Alignment.center,
            child: const Text(
              '說明',
              textAlign: TextAlign.center,
              style: TextStyle(
                  //letterSpacing: 10,
                  fontSize: 18,
                  //fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          Container(
            alignment: const Alignment(1, 0),
            child: const Icon(
              Icons.double_arrow,
              color: Color.fromARGB(177, 59, 59, 59),
            ),
          )
        ]),
      ),
    );
  }
}
