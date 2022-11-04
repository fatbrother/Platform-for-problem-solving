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
      final Map<String, dynamic> result = await DB.getRow('users', userId);
      return UsersModel.fromMap(result);
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
    try {
      await DB.addRow('users', usersModel.toMap());
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
  List<String> expertiseTagIds;
  int tokens;
  double score;
  int numberOfScores;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.askProblemIds = const [],
    this.expertiseTagIds = const [],
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
      expertiseTagIds: data['expertiseTagIds'] ?? [],
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
      'expertiseTagIds': expertiseTagIds,
      'tokens': tokens,
      'score': score,
      'numberOfScores': numberOfScores,
    };
  }

  bool isVerified() {
    return phone != "";
  }
}