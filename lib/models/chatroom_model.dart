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
