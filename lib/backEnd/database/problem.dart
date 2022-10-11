import 'database.dart';

class ProblemsDatabase {
  static Future<List> queryAllProblems() async {
    try {
      final List result = await DB.getTable('problems');
      return result;
    }
    catch (e) {
      rethrow;
    }
  }

  static Future<ProblemsModel> queryProblem(String problemId) async {
    try {
      final Map<String, dynamic> result = await DB.getRow('problems', problemId);
      return ProblemsModel.fromMap(result);
    }
    catch (e) {
      rethrow;
    }
  }

  static void updateProblem(ProblemsModel problem) async {
    try {
      await DB.updateRow('problems', problem.id, problem.toMap());
    }
    catch (e) {
      rethrow;
    }
  }

  static void deleteProblem(String problemId) async {
    try {
      await DB.deleteRow('problems', problemId);
    }
    catch (e) {
      rethrow;
    }
  }

  static void addProblem(ProblemsModel problem) async {
    try {
      await DB.addRow('problems', problem.toMap());
    }
    catch (e) {
      rethrow;
    }
  }
}

class ProblemsModel {
  String id;
  String title;
  String description;
  List<String> imgUrls;
  List<int> tags;
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
    required this.imgUrls,
    required this.tags,
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
      tags: data['tags'] ?? [],
      description: data['description'] ?? '',
      imgUrls: data['imgUrls'] ?? [],
      isSolved: data['isSolved'] ?? false,
      baseToken: data['baseToken'] ?? 10,
      solveCommendIds: data['solveCommendIds'] ?? [],
      chooseSolveCommendId: data['chooseSolveCommendId'] ?? '',
      createdAt: data['createdAt'] ?? DateTime.now(),
      remainingDays: data['remainingDays'] ?? 3,
      rewardToken: data['rewardToken'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tags': tags,
      'description': description,
      'imgUrls': imgUrls,
      'isSolved': isSolved,
      'baseToken': baseToken,
      'solveCommendIds': solveCommendIds,
      'createdAt': createdAt,
      'remainingDays': remainingDays,
      'rewardToken': rewardToken,
    };
  }

  get isSolvedString {
    return isSolved ? 'Solved' : 'Unsolved';
  }

  get remainingDaysString {
    return '$remainingDays days';
  }

  get isOverdue {
    return createdAt.add(Duration(days: remainingDays)).isBefore(DateTime.now());
  }

  get remainingTimeString {
    final DateTime now = DateTime.now();
    final DateTime deadline = createdAt.add(Duration(days: remainingDays));
    final Duration remainingTime = deadline.difference(now);
    final int days = remainingTime.inDays;
    final int hours = remainingTime.inHours - days * 24;
    final int minutes = remainingTime.inMinutes - days * 24 * 60 - hours * 60;
    final int seconds =
        remainingTime.inSeconds - days * 24 * 60 * 60 - hours * 60 * 60 - minutes * 60;
    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }
}
