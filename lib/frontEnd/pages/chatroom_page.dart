import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/frontEnd/widgets/messagebox.dart';
import 'package:pops/backEnd/other/chat_room.dart';
import 'package:pops/frontEnd/routes.dart';

// void _submitText(String text) {
//   print(text);
// }

class Chatroom extends StatefulWidget {
  const Chatroom({
    Key? key,
  }) : super(key: key);

  @override
  ChatroomState createState() => ChatroomState();
}

class ChatroomState extends State<Chatroom> {
  final TextEditingController chatController = TextEditingController();
  final List<Message> message = [
    Message(text: "HI", isMe: true),
    Message(text: "HI", isMe: false),
    Message(text: "How is your day", isMe: true),
    Message(text: "Not Bad", isMe: false)
  ];

  void submitText(String text) {
    if (text == "") return;

    chatController.clear();
    setState(() {
      message.insert(0, Message(text: text, isMe: true));
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
                  onPressed: () {
                    Routes.back(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
          //Whiteboard
          Expanded(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              padding: Design.spacing,
              itemCount: message.length,
              itemBuilder: (context, index) => Row(
                  mainAxisAlignment: message[index].isMe
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: (message[index].isMe)
                            ? Design.primaryColor
                            : Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Text(
                        message[index].text,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Icon(Icons.person, size: 32)
                  ]),
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
