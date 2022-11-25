import '../database.dart';

// control the database of the problem with problemsModels
class UsersDatabase {
  static Future<List> queryAllUsers() async {
    try {
      final List result = await DB.getTable('users');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<UsersModel> queryUser(String userId) async {
    try {
      return UsersModel.fromMap(await DB.getRow('users', userId));
    } catch (e) {
      rethrow;
    }
  }

  static void updateUser(UsersModel usersModel) async {
    try {
      await DB.updateRow('users', usersModel.id, usersModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static void deleteUser(String userId) async {
    try {
      await DB.deleteRow('users', userId);
    } catch (e) {
      rethrow;
    }
  }

  static void addUser(UsersModel usersModel) async {
    if (usersModel.id == '') {
      throw Exception('User ID cannot be empty');
    }

    try {
      UsersDatabase.updateUser(usersModel);
    } catch (e) {
      rethrow;
    }
  }
}

class UsersModel {
  String id;
  String name;
  String email;
  String phone;
  List<String> askProblemIds;
  List<String> pastExpertiseTags;
  List<String> expertiseTags;
  List<String> displaySystemTags;
  List<String> hideSystemTags;
  List<String> auditFailedTags;
  List<String> audittingTags;

  List<dynamic> chatRoomsIds;
  int tokens;
  double score;
  int numberOfScores;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.expertiseTags = const [],
    this.pastExpertiseTags = const [],
    this.displaySystemTags = const [],
    this.hideSystemTags = const [],
    this.auditFailedTags = const [],
    this.audittingTags = const [],
    this.askProblemIds = const [],
    this.chatRoomsIds = const [],
    this.tokens = 0,
    this.score = 0,
    this.numberOfScores = 0,
  });

  static fromMap(Map<String, dynamic> data) {
    return UsersModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      askProblemIds: data['askProblemIds'] == null
          ? []
          : data['askProblemIds'].cast<String>(),
      expertiseTags: data['expertiseTags'] == null
          ? []
          : data['expertiseTags'].cast<String>(),
      pastExpertiseTags: data['pastExpertiseTags'] == null
          ? []
          : data['pastExpertiseTags'].cast<String>(),
      displaySystemTags: data['displaySystemTags'] == null
          ? []
          : data['displaySystemTags'].cast<String>(),
      hideSystemTags: data['hideSystemTags'] == null
          ? []
          : data['hideSystemTags'].cast<String>(),
      auditFailedTags: data['auditFailedTags'] == null
          ? []
          : data['auditFailedTags'].cast<String>(),
      audittingTags: data['audittingTags'] == null
          ? []
          : data['audittingTags'].cast<String>(),
      chatRoomsIds: data['chatRoomsIds'] == null
          ? []
          : data['chatRoomsIds'].cast<String>(),
      tokens: data['tokens'] ?? 0,
      score: data['score'] ?? 0.0,
      numberOfScores: data['numberOfScores'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'askProblemIds': askProblemIds,
      'expertiseTags': expertiseTags,
      'pastExpertiseTags': pastExpertiseTags,
      'displaySystemTags': displaySystemTags,
      'hideSystemTags': hideSystemTags,
      'auditFailedTags': auditFailedTags,
      'audittingTags': audittingTags,
      'chatRoomsIds': chatRoomsIds,
      'tokens': tokens,
      'score': score,
      'numberOfScores': numberOfScores,
    };
  }

  bool isVerified() {
    return phone != "";
  }
}
