import '../database.dart';

class ChatRoomDatabase 
{
  static Future<List> queryAllChatRooms() async {
    try {
      final List result = await DB.getTable('chatRooms');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ChatRoomModel> queryChatRoom(String id) async {
    try {
      final Map<String, dynamic> result = await DB.getRow('chatRooms', id);
      return ChatRoomModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
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

class ChatRoomModel 
{
  String id;
  List<String> memberIds;
  // store messeages with user id and message
  // use messeaage[id] to get user's id
  // use messeaage[message] to get user's message
  List<Map<String, String>> messages;

  ChatRoomModel({
    required this.id,
    required this.memberIds,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'memberIds': memberIds,
      'messages': messages,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      id: map['id'],
      memberIds: List<String>.from(map['memberIds']),
      messages: List<Map<String, String>>.from(map['messages']),
    );
  }
}