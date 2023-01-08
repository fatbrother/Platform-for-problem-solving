import 'package:pops/services/database.dart';
import 'package:pops/models/report_model.dart';

// control the database of the problem with problemsModels
class ReportsDataBase {
  static Future<List> queryAllReports() async {
    try {
      final List result = await DB.getTable('reports');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ReportsModel> queryReport(String reportId) async {
    try {
      final Map<String, dynamic> result =
          await DB.getRow('reports', reportId);
      return ReportsModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  static void updateReport(ReportsModel report) async {
    try {
      await DB.updateRow('reports', report.id, report.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static void deleteReport(String reportId) async {
    try {
      await DB.deleteRow('reports', reportId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> addReport(ReportsModel report) async {
    try {
      String id = await DB.addRow('reports', report.toMap());
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
