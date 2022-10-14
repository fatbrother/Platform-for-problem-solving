import 'database.dart';

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

  static void addReport(ReportsModel report) async {
    try {
      await DB.addRow('reports', report.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

class ReportsModel {
  static const List<String> _reportsTypes = ['foul', 'empty', 'meaningless', 'other'];
  String id;
  String reportType;
  String reportDescription;
  String reporterId;
  String beReportedId;
  bool isVerified;

  ReportsModel({
    required this.id,
    this.reportType = 'other',
    this.reportDescription = '',
    required this.reporterId,
    required this.beReportedId,
    this.isVerified = false,
  });

  factory ReportsModel.fromMap(Map<String, dynamic> map) {
    return ReportsModel(
      id: map['id'] ?? '',
      reportType: map['reportType'] ?? _reportsTypes.last,
      reportDescription: map['reportDescription'] ?? '',
      reporterId: map['reporterId'] ?? '',
      beReportedId: map['beReportedId'] ?? '',
      isVerified: map['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reportType': reportType,
      'reportDescription': reportDescription,
      'reporterId': reporterId,
      'beReportedId': beReportedId,
      'isVerified': isVerified,
    };
  }
}