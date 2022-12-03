import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/backEnd/other/chat_room.dart';
import 'package:pops/frontEnd/routes.dart';

class ChatRoomPage extends StatefulWidget {
  final String chatRoomId;

  const ChatRoomPage({
    Key? key,
    required this.chatRoomId,
  }) : super(key: key);

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController chatController = TextEditingController();
  Stream<QuerySnapshot> chatRoomListener = const Stream.empty();
  UsersModel user = UsersModel(id: '', name: '', email: '');
  List<Messeage> messages = [];

  Future<void> submitText(String text) async {
    if (text == '') {
      return;
    }
    final Messeage message = Messeage(
      id: user.id,
      message: text,
    );
    messages.add(message);

    var chatRoom = await ChatRoomDatabase.getChatRoom(widget.chatRoomId);
    chatRoom.messages = messages;
    ChatRoomDatabase.updateChatRoom(chatRoom);
  }

  void listenChatRoom() {
    chatRoomListener = ChatRoomDatabase.getChatRoomListener(widget.chatRoomId);
    chatRoomListener.listen((event) {
      messages = event.docs
          .map((e) => Messeage.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      setState(() {});
    });
  }

  Future<void> loadUserInfo() async {
    user = await AccountManager.currentUser;
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
    listenChatRoom();
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
              itemCount: messages.length,
              itemBuilder: (context, index) => Row(
                  mainAxisAlignment: messages[index].id == user.id
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    messages[index].type == 0
                        ? Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: (messages[index].id == user.id)
                                  ? Design.primaryColor
                                  : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Text(
                              messages[index].message,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: (messages[index].id == user.id)
                                  ? Design.primaryColor
                                  : Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Image.network(messages[index].message),
                          ),
                    const Icon(Icons.person, size: 32)
                  ]),
            ),
          ),
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
