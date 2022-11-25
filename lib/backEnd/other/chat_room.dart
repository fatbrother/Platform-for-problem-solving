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

class Messeaage {
  String id;
  String message;

  Messeaage({
    required this.id,
    required this.message,
  });

  Map<String, String> toMap() {
    return {
      'id': id,
      'message': message,
    };
  }

  factory Messeaage.fromMap(Map<String, dynamic> map) {
    return Messeaage(
      id: map['id'],
      message: map['message'],
    );
  }
}

class ChatRoomModel 
{
  String id;
  List<String> memberIds;
  List<Messeaage> messages;

  ChatRoomModel({
    required this.id,
    required this.memberIds,
    required this.messages,
  });

  Map<String, dynamic> toMap() {
    List<Map<String, String>> messagesMap = [];
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
    List<Messeaage> result = [];
    for (var value in map['messages']) {
      result.add(Messeaage.fromMap(value));
    }
    return ChatRoomModel(
      id: map['id'],
      memberIds: List<String>.from(map['memberIds']),
      messages: result,
    );
  }
}

