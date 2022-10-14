import 'package:cloud_firestore/cloud_firestore.dart';
export 'problem.dart';
export 'user.dart';
export 'report.dart';
export 'tag.dart';
export 'solve_commend.dart';

class DB {
  static final db = FirebaseFirestore.instance;

  static Future<List> getTable(String tableName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection(tableName).get();
      return querySnapshot.docs.isEmpty
          ? throw Exception('No data found')
          : querySnapshot.docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                  doc.data())
              .toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getRow(
      String tableName, String rowId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await db.collection(tableName).get();
      return querySnapshot.docs.isEmpty
          ? throw Exception('No data found')
          : querySnapshot.docs
              .firstWhere((element) => element.id == rowId)
              .data();
    } catch (e) {
      rethrow;
    }
    // if not found
  }

  static Future<void> updateRow(
      String tableName, String rowId, Map<String, dynamic> row) async {
    try {
      await db.collection(tableName).doc(rowId).set(row);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteRow(String tableName, String rowId) async {
    try {
      await db.collection(tableName).doc(rowId).delete();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addRow(String tableName, Map<String, dynamic> row) async {
    try {
      await db.collection(tableName).add(row);
    } catch (e) {
      rethrow;
    }
  }
}
