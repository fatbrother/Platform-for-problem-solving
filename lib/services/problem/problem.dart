import 'package:pops/models/problem_model.dart';
import 'package:pops/models/tag_model.dart';
import 'package:pops/services/other/chat_room.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/services/problem/contract.dart';
import 'package:pops/services/database.dart';

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
      try {
        await ContractsDatabase.deleteContract(problem.chooseSolveCommendId);
      } catch (e) {
        // pass
      }
      try {
        for (final contractId in problem.solveCommendIds) {
          await ContractsDatabase.deleteContract(contractId);
        }
      } catch (e) {
        // pass
      }

      if (problem.chatRoomId != '') {
        ChatRoomDatabase.deleteChatRoom(problem.chatRoomId);
      }

      try {
        for (final tag in problem.tags) {
          TagsModel? tmp = TagsDatabase.queryTag(tag);
          tmp!.problemsWithTag.remove(problemId);
          await TagsDatabase.updateTag(tmp);
        }
      } catch (e) {
        // pass
      }
      try {
        for (final imgId in problem.imgIds) {
          await ImgManager.deleteImage(imgId);
        }
      } catch (e) {
        // pass
      }
      var user = await UsersDatabase.instance.query(problem.authorId);
      user.chatRoomsIds.remove(problem.chatRoomId);
      user.askProblemIds.remove(problem.id);
      for (final folder in user.folders) {
        if (folder.problemIds.contains(problemId)) {
          folder.problemIds.remove(problemId);
        }
      }
      await UsersDatabase.instance.update(user);
      if (problem.solverId != '') {
        var solver = await UsersDatabase.instance.query(problem.solverId);
        solver.commandProblemIds.remove(problem.id);
        solver.chatRoomsIds.remove(problem.chatRoomId);
        await UsersDatabase.instance.update(solver);
      }
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
