import 'database.dart';

// control the database of the problem with problemsModels
class SolveCommendsDatabase {
  static Future<List> queryAllSolveCommends() async {
    try {
      final List result = await DB.getTable('solveCommends');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<SolveCommendsModel> querySolveCommend(String solveCommendId) async {
    try {
      final Map<String, dynamic> result =
          await DB.getRow('solveCommends', solveCommendId);
      return SolveCommendsModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateSolveCommend(SolveCommendsModel solveCommend) async {
    try {
      await DB.updateRow('solveCommends', solveCommend.id, solveCommend.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteSolveCommend(String solveCommendId) async {
    try {
      await DB.deleteRow('solveCommends', solveCommendId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addSolveCommend(SolveCommendsModel solveCommend) async {
    try {
      await DB.addRow('solveCommends', solveCommend.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

class SolveCommendsModel {
  String id;
  String commendUserId;
  int tokens;

  SolveCommendsModel({
    required this.id,
    required this.commendUserId,
    required this.tokens,
  });

  static fromMap(Map<String, dynamic> map) {
    return SolveCommendsModel(
      id: map['id'],
      commendUserId: map['commendUserId'],
      tokens: map['tokens'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'commendUserId': commendUserId,
      'tokens': tokens,
    };
  }  
}