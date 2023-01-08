import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pops/models/chatroom_model.dart';
import 'package:pops/services/database.dart';

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
