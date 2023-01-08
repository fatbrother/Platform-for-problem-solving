class ReportsModel {
  static const List<String> reportsTypes = ['空白答案', '不雅字眼', '答案與問題無關', '其他'];
  String id;
  String reportType;
  String reportDescription;
  String reporterId;
  String beReporterId;
  String problemId;
  bool isVerified;
  bool isSucceeded;

  ReportsModel({
    this.id = '',
    this.reportType = 'other',
    this.reportDescription = '',
    this.reporterId = '',
    this.beReporterId = '',
    this.problemId = '',
    this.isVerified = false,
    this.isSucceeded = false,
  });

  factory ReportsModel.fromMap(Map<String, dynamic> map) {
    return ReportsModel(
      id: map['id'] ?? '',
      reportType: map['reportType'] ?? reportsTypes.last,
      reportDescription: map['reportDescription'] ?? '',
      reporterId: map['reporterId'] ?? '',
      beReporterId: map['beReporterId'] ?? '',
      problemId: map['problemId'] ?? '',
      isVerified: map['isVerified'] ?? false,
      isSucceeded: map['isSucceeded'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reportType': reportType,
      'reportDescription': reportDescription,
      'reporterId': reporterId,
      'beReporterId': beReporterId,
      'problemId': problemId,
      'isVerified': isVerified,
      'isSucceeded': isSucceeded,
    };
  }
}