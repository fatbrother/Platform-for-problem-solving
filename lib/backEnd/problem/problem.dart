import '../database.dart';

// control the database of the problem with problemsModel
class ProblemsDatabase {
  static Future<List<ProblemsModel>> queryAllProblems() async {
    try {
      List<ProblemsModel> result = [];
      for (var item in await DB.getTable('problems')) {
        result.add(ProblemsModel.fromMap(item));
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ProblemsModel> queryProblem(String problemId) async {
    try {
      final Map<String, dynamic> result =
          await DB.getRow('problems', problemId);
      return ProblemsModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  static void updateProblem(ProblemsModel problem) async {
    try {
      await DB.updateRow('problems', problem.id, problem.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static void deleteProblem(String problemId) async {
    try {
      await DB.deleteRow('problems', problemId);
    } catch (e) {
      rethrow;
    }
  }

  static void addProblem(ProblemsModel problem) async {
    try {
      await DB.addRow('problems', problem.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

class ProblemsModel {
  String id;
  String title;
  String description;
  String authorName;
  String authorId;
  List<String> imgIds;
  List<int> tagIds;
  int baseToken;
  bool isSolved;
  List<String> solveCommendIds;
  String chooseSolveCommendId;
  DateTime createdAt;
  int remainingDays;
  int rewardToken;

  ProblemsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.authorName,
    required this.authorId,
    required this.imgIds,
    required this.tagIds,
    required this.isSolved,
    required this.baseToken,
    required this.solveCommendIds,
    required this.chooseSolveCommendId,
    required this.createdAt,
    required this.remainingDays,
    required this.rewardToken,
  });

  static fromMap(Map<String, dynamic> data) {
    return ProblemsModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      tagIds: data['tags'] == null ? [] : data['tags'].cast<String>() ?? [],
      description: data['description'] ?? '',
      authorName: data['authorName'] ?? '',
      authorId: data['authorId'] ?? '',
      imgIds: data['imgIds'] == null ? [] : data['imgIds'].cast<String>(),
      isSolved: data['isSolved'] ?? false,
      baseToken: data['baseToken'] ?? 10,
      solveCommendIds: data['solveCommendIds'] == null
          ? []
          : data['solveCommendIds'].cast<String>(),
      chooseSolveCommendId: data['chooseSolveCommendId'] ?? '',
      createdAt: data['createdAt']
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
      remainingDays: data['remainingDays'] ?? 3,
      rewardToken: data['rewardToken'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tagIds': tagIds,
      'description': description,
      'authorName': authorName,
      'authorId': authorId,
      'imgIds': imgIds,
      'isSolved': isSolved,
      'baseToken': baseToken,
      'solveCommendIds': solveCommendIds,
      'createdAt': createdAt.toIso8601String(),
      'remainingDays': remainingDays,
      'rewardToken': rewardToken,
    };
  }

  bool get isOverdue {
    return createdAt
        .add(Duration(days: remainingDays))
        .isBefore(DateTime.now());
  }

  String get existTimeString {
    final DateTime now = DateTime.now();
    final DateTime deadline = createdAt.add(Duration(days: remainingDays));
    final Duration existTime = deadline.difference(now);
    final int days = existTime.inDays;
    final int hours = existTime.inHours - days * 24;
    final int minutes = existTime.inMinutes - days * 24 * 60 - hours * 60;
    final int seconds = existTime.inSeconds -
        days * 24 * 60 * 60 -
        hours * 60 * 60 -
        minutes * 60;

    if (days > 0) {
      return '$days days';
    } else if (hours > 0) {
      return '$hours hours';
    } else if (minutes > 0) {
      return '$minutes minutes';
    } else {
      return '$seconds seconds';
    }
  }
}
