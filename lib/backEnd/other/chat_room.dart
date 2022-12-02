import 'package:cloud_firestore/cloud_firestore.dart';

import '../database.dart';

class ChatRoomDatabase {
  // use id to query database and return a listener
  static Stream<QuerySnapshot> getChatRoomListener(String id) {
    return FirebaseFirestore.instance
        .collection('chatRoom')
        .doc(id)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots();
  }

  static Future<ChatRoomModel> getChatRoom(String id) async {
    ChatRoomModel model = ChatRoomModel.fromMap(
        (await DB.getRow('chatRoom', id)));
    return model;
  }

  static void updateChatRoom(ChatRoomModel hatRoomModel) async {
    try {
      await DB.updateRow('chatRooms', hatRoomModel.id, hatRoomModel.toMap());
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

  static void addChatRoom(ChatRoomModel chatRoomModel) async {
    try {
      await DB.addRow('chatRooms', chatRoomModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

class Messeage {
  String id;
  String message;
  // 0 for text, 1 for image
  int type;

  Messeage({
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

  factory Messeage.fromMap(Map<String, dynamic> map) {
    return Messeage(
      id: map['id'],
      message: map['message'],
      type: map['type'],
    );
  }
}

class ChatRoomModel {
  String id;
  List<String> memberIds;
  List<Messeage> messages;

  ChatRoomModel({
    required this.id,
    required this.memberIds,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> messagesMap = [];
    for (var message in messages) {
      messagesMap.add(message.toMap());
    }
    return {
      'id': id,
      'memberIds': memberIds,
      'messages': messages,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    List<Messeage> result = [];
    for (var value in map['messages']) {
      result.add(Messeage.fromMap(value));
    }
    return ChatRoomModel(
      id: map['id'],
      memberIds: List<String>.from(map['memberIds']),
      messages: result,
    );
  }
}
