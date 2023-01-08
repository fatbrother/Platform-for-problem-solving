import 'package:pops/models/chatroom_model.dart';
import 'package:pops/services/services_base.dart';

class ChatRoomDatabase extends ServiceBase<ChatRoomModel>
    with Query, Update, Delete, Add, GetStream {
  // use id to query database and return a listener
  @override
  String get tableName => 'chatRooms';

  @override
  ChatRoomModel fromMap(Map<String, dynamic> map) {
    return ChatRoomModel.fromMap(map);
  }

  static final ChatRoomDatabase instance = ChatRoomDatabase();
}
