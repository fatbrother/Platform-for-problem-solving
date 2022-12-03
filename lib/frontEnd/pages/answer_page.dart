import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';

class AnswerPage extends StatelessWidget {
  const AnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                  top: 35, left: 25, right: 25, bottom: 5),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
                size: 30,
              )),
          SizedBox(
              height: 690,
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            right: 20, left: 20, top: 10, bottom: 5),
                        padding: Design.spacing,
                        constraints: const BoxConstraints(
                          minHeight: 42,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const Text(
                          '題目標題',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 20, left: 20, top: 5, bottom: 5),
                        padding: Design.spacing,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const Text(
                          '題目內容',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 20, left: 20, top: 5, bottom: 0),
                        padding: Design.spacing,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const Text(
                          '答案內容',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 190,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      chooseReportDialog(context, '進入檢舉流程後便無法取消');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(79, 128, 155, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      '檢舉',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 190,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      chooseFinishDialog(context, '完成交易後便無法再提出檢舉，\n聊天室也將關閉。');
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color.fromRGBO(79, 128, 155, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text(
                      '完成交易',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor:
            const Color.fromRGBO(166, 198, 222, 0.5254901960784314),
        child: const Icon(Icons.chat),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

chooseFinishDialog(BuildContext context, String message) {
  AlertDialog dialog = AlertDialog(
    title: const Text(
      '完成交易',
      style: TextStyle(color: Colors.black, fontSize: 12),
    ),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //title: const Text("Confirm Dialog"),
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      SizedBox(
        width: 600,
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 154,
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(79, 128, 155, 180),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ))),
                child: const Text("完成交易",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              width: 154,
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(0, 0, 0, 200),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ))),
                child: const Text("取消",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      )
    ],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // Show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

chooseReportDialog(BuildContext context, String message) {
  AlertDialog dialog = AlertDialog(
    title: const Text(
      '提出檢舉',
      style: TextStyle(color: Colors.black, fontSize: 12),
    ),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 0.0),
    //title: const Text("Confirm Dialog"),
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    actions: <Widget>[
      SizedBox(
        width: 600,
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 154,
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(79, 128, 155, 180),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ))),
                child: const Text("提出檢舉",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              width: 154,
              height: 40,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromRGBO(0, 0, 0, 200),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                      ),
                    ))),
                child: const Text("取消",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      )
    ],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
  // Show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}
