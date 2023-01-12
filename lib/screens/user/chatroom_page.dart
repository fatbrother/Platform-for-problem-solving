import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pops/models/user_model.dart';
import 'package:pops/models/chatroom_model.dart';
import 'package:pops/services/other/chat_room.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/utilities/account.dart';
import 'package:pops/utilities/design.dart';
import 'package:pops/utilities/dialog.dart';
import 'package:pops/widgets/main/app_bar.dart';

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
  UsersModel user = UsersModel();
  List<Message> messages = [];

  Future<void> submitText(Message message) async {
    if (message.message == '') {
      return;
    }
    messages.add(message);

    var chatRoom = await ChatRoomDatabase.instance.query(widget.chatRoomId);
    chatRoom.messages = messages;
    ChatRoomDatabase.instance.update(chatRoom);
  }

  Future<void> loadInfo() async {
    user = await AccountManager.currentUser;
    ChatRoomModel chatRoom =
        await ChatRoomDatabase.instance.query(widget.chatRoomId);
    if (chatRoom.messages.length > messages.length) {
      messages = chatRoom.messages;
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: ChatRoomDatabase.instance.getStream(widget.chatRoomId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          loadInfo();
        }
        return Scaffold(
          backgroundColor: Design.backgroundColor,
          appBar: const GoBackBar(),
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
                              onPressed: selectImg,
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
                                  Message(id: user.id, message: value, type: 0),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                submitText(Message(
                                  id: user.id,
                                  message: chatController.text,
                                  type: 0,
                                ));
                                chatController.clear();
                              },
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  void selectImg() async {
    String url = "";
    try {
      url = await ImgManager.uploadImage();
    } catch (e) {
      if (e.toString().contains('No image selected')) {
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
        !isMe
            ? const Icon(Icons.person_outline_outlined, size: 32)
            : const SizedBox(),
        const SizedBox(width: 10),
        message.type == 0
            ? Container(
                padding: Design.spacing,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                constraints: BoxConstraints(
                  maxWidth: Design.getScreenWidth(context) * 0.7,
                ),
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
        isMe
            ? const Icon(Icons.person_outline_outlined, size: 32)
            : const SizedBox(),
      ],
    );
  }
}
