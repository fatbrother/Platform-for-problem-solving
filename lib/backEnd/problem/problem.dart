import 'package:pops/backEnd/other/img.dart';
import 'package:pops/backEnd/problem/contract.dart';

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
      ProblemsModel problem = await queryProblem(problemId);
      for (final contractId in problem.solveCommendIds) {
        ContractsDatabase.deleteContract(contractId);
      }
      ContractsDatabase.deleteContract(problem.chooseSolveCommendId);
      for (final tag in problem.tags) {
        TagsModel? tmp = TagsDatabase.queryTag(tag);
        tmp!.problemsWithTag.remove(problemId);
        TagsDatabase.updateTag(tmp);
      }
      for (final imgId in problem.imgIds) {
        ImgManager.deleteImage(imgId);
      }
      var user = await UsersDatabase.queryUser(problem.authorId);
      for (final folder in user.folders) {
        if (folder.problemIds.contains(problemId)) {
          folder.problemIds.remove(problemId);
        }
      }
      user.askProblemIds.remove(problemId);
      UsersDatabase.updateUser(user);
      await DB.deleteRow('problems', problemId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> addProblem(ProblemsModel problem) async {
    try {
      String id = await DB.addRow('problems', problem.toMap());
      return id;
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
  List<String> tags;
  int baseToken;
  bool isSolved;
  List<String> solveCommendIds;
  String chooseSolveCommendId;
  DateTime createdAt;
  int rewardToken;

  ProblemsModel({
    required this.id,
    required this.title,
    required this.authorName,
    required this.authorId,
    required this.createdAt,
    this.description = '',
    this.imgIds = const [],
    this.tags = const [],
    this.isSolved = false,
    this.baseToken = 0,
    this.solveCommendIds = const [],
    this.chooseSolveCommendId = '',
    this.rewardToken = 0,
  });

  static fromMap(Map<String, dynamic> data) {
    return ProblemsModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      tags: data['tags'] == null ? [] : data['tags'].cast<String>(),
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
      createdAt: DateTime.parse(data['createdAt']),
      rewardToken: data['rewardToken'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authorName': authorName,
      'authorId': authorId,
      'imgIds': imgIds,
      'tags': tags,
      'isSolved': isSolved,
      'baseToken': baseToken,
      'solveCommendIds': solveCommendIds,
      'chooseSolveCommendId': chooseSolveCommendId,
      'createdAt': createdAt.toIso8601String(),
      'rewardToken': rewardToken,
    };
  }

  String get existTimeString {
    final DateTime now = DateTime.now();
    final Duration existTime = now.difference(createdAt);
    final int days = existTime.inDays;
    final int hours = existTime.inHours;
    final int minutes = existTime.inMinutes;
    final int seconds = existTime.inSeconds;

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
