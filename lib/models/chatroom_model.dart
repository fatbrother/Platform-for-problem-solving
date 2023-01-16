import 'package:pops/models/model_base.dart';

class Message extends ModelBase {
  @override
  String id;
  String message;
  // 0 for text, 1 for image
  int type;

  Message({
    required this.id,
    required this.message,
    this.type = 0,
  });

  @override
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

class ChatRoomModel extends ModelBase {
  @override
  String id;
  List<String> memberIds;
  List<Message> messages;

  ChatRoomModel({
    this.id = '',
    this.memberIds = const [],
    this.messages = const [],
  });

  @override
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
