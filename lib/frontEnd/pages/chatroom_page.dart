import 'package:flutter/material.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/messagebox.dart';


class Chatroom extends StatefulWidget {
  const Chatroom({
    Key? key,
  }) : super(key: key);

  @override
  ChatroomState createState() => ChatroomState();
}

class ChatroomState extends State<Chatroom> {
  final TextEditingController chatController = TextEditingController();
  final List<Widget> message = [];

  void submitText(String text) {
    if (text == "") return;

    chatController.clear();
    setState(() {
      message.insert(0, MessageBox(text: text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Design.backgroundColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: Design.getScreenHeight(context) * 0.04,
          ),
          //BackButton
          Center(
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
          //Whiteboard
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: Design.spacing,
              itemBuilder: (context, index) => message[index],
              itemCount: message.length,
            ),
          ),
          //Bottom_TypingSquare_Design
          Center(
            child: Container(
              width: Design.getScreenWidth(context) * 0.95,
              height: Design.getScreenHeight(context) * 0.06,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: Design.outsideBorderRadius,
              ),
              margin: EdgeInsets.only(
                  bottom: Design.getScreenHeight(context) * 0.01),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.abc),
                  ),
                  Flexible(
                    child: TextField(
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Aa...',
                      ),
                      controller: chatController,
                      onSubmitted: submitText,
                    ),
                  ),
                  IconButton(
                    onPressed: () => submitText(chatController.text),
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
