import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsDataBase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot =
      FirebaseFirestore.instance.collection('reports').get()
          as QuerySnapshot<Map<String, dynamic>>;

  static Future<List> queryAllReports() async {
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            ReportsModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static Future<ReportsModel> queryReport(String reportId) async {
    final ReportsModel result = ReportsModel.fromMap(querySnapshot.docs
        .firstWhere((element) => element.id == reportId)
        .data());
    return result;
  }

  static void updateReport(ReportsModel report) async {
    await FirebaseFirestore.instance
        .collection('reports')
        .doc(report.id)
        .set(report.toMap());

    updateQuerySnapshot();
  }

  static void deleteReport(String reportId) async {
    await FirebaseFirestore.instance
        .collection('reports')
        .doc(reportId)
        .delete();

    updateQuerySnapshot();
  }

  static void addReport(ReportsModel report) async {
    await FirebaseFirestore.instance
        .collection('reports')
        .add(report.toMap());

    updateQuerySnapshot();
  }

  static void updateQuerySnapshot() async {
    querySnapshot =
        await FirebaseFirestore.instance.collection('reports').get();
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