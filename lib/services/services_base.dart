import 'package:pops/services/database.dart';
import 'package:pops/models/model_base.dart';

abstract class ServiceBase<T extends ModelBase> {
  String get tableName;
  T fromMap(Map<String, dynamic> map);
}

mixin QueryAll<T extends ModelBase> on ServiceBase<T> {
  Future<List<T>> queryAll() async {
    try {
      final List<Map<String, dynamic>> table =
          await DB.getTable(tableName);
      return table.map((e) => fromMap(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

mixin Query<T extends ModelBase> on ServiceBase<T> {
  Future<T> query(String id) async {
    try {
      final Map<String, dynamic> row =
          await DB.getRow(tableName, id);
      if (row.isEmpty) throw Exception('No data found');
      return fromMap(row);
    } catch (e) {
      rethrow;
    }
  }
}

mixin Update<T extends ModelBase> on ServiceBase<T> {
  Future<void> update(T model) async {
    try {
      await DB.updateRow(
        tableName,
        model.id,
        model.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }
}

mixin Delete<T extends ModelBase> on ServiceBase<T> {
  Future<void> delete(String id) async {
    try {
      await DB.deleteRow(tableName, id);
    } catch (e) {
      rethrow;
    }
  }
}

mixin Add<T extends ModelBase> on ServiceBase<T> {
  Future<String> add(T model) async {
    try {
      String id = await DB.addRow(tableName, model.toMap());
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
