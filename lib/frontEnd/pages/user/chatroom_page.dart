import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pops/backEnd/other/img.dart';
import 'package:pops/backEnd/user/account.dart';
import 'package:pops/backEnd/user/user.dart';
import 'package:pops/frontEnd/design.dart';
import 'package:pops/backEnd/other/chat_room.dart';
import 'package:pops/frontEnd/widgets/app_bar.dart';
import 'package:pops/frontEnd/widgets/dialog.dart';

class ChatRoomPage extends StatefulWidget {
  final String chatRoomId;
  final bool canEdit;

  const ChatRoomPage({
    Key? key,
    required this.chatRoomId,
    this.canEdit = true,
  }) : super(key: key);

  @override
  ChatRoomPageState createState() => ChatRoomPageState();
}

class ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController chatController = TextEditingController();
  UsersModel user = UsersModel(id: '', name: '', email: '');
  List<Message> messages = [];

  Future<void> submitText(Message message) async {
    chatController.clear();
    if (message.message == '') {
      return;
    }
    messages.add(message);

    var chatRoom = await ChatRoomDatabase.getChatRoom(widget.chatRoomId);
    chatRoom.messages = messages;
    ChatRoomDatabase.updateChatRoom(chatRoom);
  }

  Future<void> loadInfo() async {
    user = await AccountManager.currentUser;
    ChatRoomModel chatRoom =
        await ChatRoomDatabase.getChatRoom(widget.chatRoomId);
    messages = chatRoom.messages;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: ChatRoomDatabase.getChatRoomListener(widget.chatRoomId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            loadInfo();
          }
          return Scaffold(
            backgroundColor: Design.backgroundColor,
            appBar: const SimpleAppBar(),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    reverse: true,
                    shrinkWrap: true,
                    padding: Design.spacing,
                    children: [
                      for (final message in messages.reversed)
                        ChatLine(
                          message: message,
                          isMe: message.id == user.id,
                        ),
                    ],
                  ),
                ),
                !widget.canEdit
                    ? const SizedBox()
                    : Center(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Design.insideColor,
                            borderRadius: Design.outsideBorderRadius,
                          ),
                          margin: Design.spacing,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () async {
                                  String url = "";
                                  try {
                                    url = await ImgManager.uploadImage();
                                  } catch (e) {
                                    if (e
                                        .toString()
                                        .contains('No image selected')) {
                                      DialogManager.showInfoDialog(
                                        context,
                                        '未選擇圖片',
                                      );
                                      return;
                                    }
                                  }
                                  Message message = Message(
                                    id: user.id,
                                    message: url,
                                    type: 1,
                                  );
                                  submitText(message);
                                },
                                icon: const Icon(Icons.image),
                              ),
                              Flexible(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    fillColor: Design.insideColor,
                                    filled: true,
                                    border: InputBorder.none,
                                    hintText: 'Aa...',
                                  ),
                                  controller: chatController,
                                  onSubmitted: (value) => submitText(
                                    Message(
                                      id: user.id,
                                      message: value,
                                      type: 0,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => submitText(
                                  Message(
                                    id: user.id,
                                    message: chatController.text,
                                    type: 0,
                                  ),
                                ),
                                icon: const Icon(Icons.send),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          );
        });
  }
}

class ChatLine extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatLine({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        message.type == 0
            ? Container(
                padding: Design.spacing,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: (isMe) ? Design.secondaryColor : Colors.white,
                  borderRadius: Design.outsideBorderRadius,
                ),
                child: Text(
                  message.message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              )
            : Container(
                padding: Design.spacing,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: (isMe) ? Design.secondaryColor : Colors.white,
                  borderRadius: Design.outsideBorderRadius,
                ),
                child: Image.network(message.message),
              ),
        const SizedBox(width: 10.0),
        const Icon(Icons.person_outline_outlined, size: 32),
      ],
    );
  }
}
