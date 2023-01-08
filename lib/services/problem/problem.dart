import 'package:pops/models/problem_model.dart';
import 'package:pops/models/tag_model.dart';
import 'package:pops/services/database.dart';
import 'package:pops/services/other/chat_room.dart';
import 'package:pops/services/other/img.dart';
import 'package:pops/services/problem/contract.dart';
import 'package:pops/services/services_base.dart';

// control the database of the problem with problemsModel
class ProblemsDatabase extends ServiceBase<ProblemsModel>
    with QueryAll, Query, Update, Delete, Add {
  static final ProblemsDatabase instance = ProblemsDatabase();

  @override
  String get tableName => 'problems';

  @override
  Future<void> delete(String id) async {
    try {
      ProblemsModel problem = await query(id);
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
          tmp!.problemsWithTag.remove(id);
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
        if (folder.problemIds.contains(id)) {
          folder.problemIds.remove(id);
        }
      }
      await UsersDatabase.instance.update(user);
      if (problem.solverId != '') {
        var solver = await UsersDatabase.instance.query(problem.solverId);
        solver.commandProblemIds.remove(problem.id);
        solver.chatRoomsIds.remove(problem.chatRoomId);
        await UsersDatabase.instance.update(solver);
      }
      await DB.deleteRow('problems', id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  ProblemsModel fromMap(Map<String, dynamic> map) => ProblemsModel.fromMap(map);
}
