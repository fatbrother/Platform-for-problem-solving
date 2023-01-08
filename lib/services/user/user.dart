import 'package:pops/services/database.dart';
import 'package:pops/models/user_model.dart';

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

  static Future<void> updateUser(UsersModel usersModel) async {
    try {
      await DB.updateRow(
        'users',
        usersModel.id,
        usersModel.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteUser(String userId) async {
    try {
      await DB.deleteRow('users', userId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addUser(UsersModel usersModel) async {
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