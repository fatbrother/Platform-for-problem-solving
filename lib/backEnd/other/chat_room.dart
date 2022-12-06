import 'package:cloud_firestore/cloud_firestore.dart';

import '../database.dart';

class ChatRoomDatabase {
  // use id to query database and return a listener
  static Stream<QuerySnapshot> getChatRoomListener(String id) {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(id)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  static Future<ChatRoomModel> getChatRoom(String id) async {
    ChatRoomModel model = ChatRoomModel.fromMap(
        (await DB.getRow('chatRooms', id)));
    return model;
  }

  static void updateChatRoom(ChatRoomModel chatRoomModel) async {
    try {
      await DB.updateRow('chatRooms', chatRoomModel.id, chatRoomModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static void deleteChatRoom(String id) async {
    try {
      await DB.deleteRow('chatRooms', id);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> addChatRoom(ChatRoomModel chatRoomModel) async {
    try {
      return await DB.addRow('chatRooms', chatRoomModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

class Message {
  String id;
  String message;
  // 0 for text, 1 for image
  int type;

  Message({
    required this.id,
    required this.message,
    this.type = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'type': type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      message: map['message'],
      type: map['type'],
    );
  }
}

class ChatRoomModel {
  String id;
  List<String> memberIds;
  List<Message> messages;

  ChatRoomModel({
    required this.id,
    required this.memberIds,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberIds': memberIds,
      'messages': messages.map((e) => e.toMap()).toList(),
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    List<Message> messages = [];
    if (map.containsKey('messages')) {
      for (final Map<String, dynamic> message in map['messages']) {
        messages.add(Message.fromMap(message));
      }
    }
    return ChatRoomModel(
      id: map.containsKey('id') ? map['id'] : '',
      memberIds: map.containsKey('memberIds')
          ? List<String>.from(map['memberIds'])
          : [],
      messages: messages,
    );
  }
}
