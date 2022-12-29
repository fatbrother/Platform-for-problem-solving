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
      await ContractsDatabase.deleteContract(problem.chooseSolveCommendId);
      for (final contractId in problem.solveCommendIds) {
        await ContractsDatabase.deleteContract(contractId);
      }
      for (final tag in problem.tags) {
        TagsModel? tmp = TagsDatabase.queryTag(tag);
        tmp!.problemsWithTag.remove(problemId);
        await TagsDatabase.updateTag(tmp);
      }
      for (final imgId in problem.imgIds) {
        await ImgManager.deleteImage(imgId);
      }
      var user = await UsersDatabase.queryUser(problem.authorId);
      for (final folder in user.folders) {
        if (folder.problemIds.contains(problemId)) {
          folder.problemIds.remove(problemId);
        }
      }
      user.askProblemIds.remove(problemId);
      await UsersDatabase.updateUser(user);
      await DB.deleteRow('problems', problemId);
    } catch (e) {
      return;
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
  String answer;
  String chatRoomId;
  bool isUpvoted = false;

  ProblemsModel({
    this.id = '',
    this.title = '',
    this.authorName = '',
    this.authorId = '',
    DateTime? createdAt,
    this.description = '',
    this.imgIds = const [],
    this.tags = const [],
    this.isSolved = false,
    this.baseToken = 0,
    this.solveCommendIds = const [],
    this.chooseSolveCommendId = '',
    this.rewardToken = 0,
    this.answer = '',
    this.chatRoomId = '',
    this.isUpvoted = false,
  }): createdAt = createdAt ?? DateTime.now();

  static fromMap(Map<String, dynamic> data) {
    return ProblemsModel(
      id: data.containsKey('id') ? data['id'] : '',
      title: data.containsKey('title') ? data['title'] : '',
      description: data.containsKey('description') ? data['description'] : '',
      authorName: data.containsKey('authorName') ? data['authorName'] : '',
      authorId: data.containsKey('authorId') ? data['authorId'] : '',
      imgIds: data.containsKey('imgIds')
          ? List<String>.from(data['imgIds'])
          : [],
      tags: data.containsKey('tags') ? List<String>.from(data['tags']) : [],
      isSolved: data.containsKey('isSolved') ? data['isSolved'] : false,
      baseToken: data.containsKey('baseToken') ? data['baseToken'] : 0,
      solveCommendIds: data.containsKey('solveCommendIds')
          ? List<String>.from(data['solveCommendIds'])
          : [],
      chooseSolveCommendId: data.containsKey('chooseSolveCommendId')
          ? data['chooseSolveCommendId']
          : '',
      createdAt: data.containsKey('createdAt')
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
      rewardToken: data.containsKey('rewardToken') ? data['rewardToken'] : 0,
      answer: data.containsKey('answer') ? data['answer'] : '',
      chatRoomId: data.containsKey('chatRoomId') ? data['chatRoomId'] : '',
      isUpvoted: data.containsKey('isUpvoted') ? data['isUpvoted'] : false,
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
      'answer': answer,
      'chatRoomId': chatRoomId,
      'isUpvoted': isUpvoted,
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
