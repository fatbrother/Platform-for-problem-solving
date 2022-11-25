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
  List<dynamic> askProblemIds;
  List<dynamic> pastExpertiseTags;
  List<dynamic> expertiseTags;
  List<dynamic> auditFailedTags;
  List<dynamic> audittingTags;
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
      askProblemIds: data['askProblemIds'] ?? [],
      expertiseTags: data['expertiseTags'] ?? [],
      pastExpertiseTags: data['pastExpertiseTags'] ?? [],
      auditFailedTags: data['auditFailedTags'] ?? [],
      audittingTags: data['audittingTags'] ?? [],
      chatRoomsIds: data['chatRoomsIds'] ?? [],
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
