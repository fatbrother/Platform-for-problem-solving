import '../database.dart';
import 'package:pops/models/audit_command_model.dart';

// control the database of the contract with contractModel
class AuditCommandsDatabase {
  static Future<List> queryAllAuditCommands() async {
    try {
      final List result = await DB.getTable('auditCommands');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<AuditCommandsModel> queryAuditCommand(String auditCommandId) async {
    try {
      final Map<String, dynamic> result =
          await DB.getRow('auditCommands', auditCommandId);
      return AuditCommandsModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  static void updateAuditCommand(AuditCommandsModel auditCommand) async {
    try {
      await DB.updateRow('auditCommands', auditCommand.id, auditCommand.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static void deleteAuditCommand(String auditCommandId) async {
    try {
      await DB.deleteRow('auditCommands', auditCommandId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> addAuditCommand(AuditCommandsModel auditCommand) async {
    try {
      final String id = await DB.addRow('auditCommands', auditCommand.toMap());
      return id;
    } catch (e) {
      rethrow;
    }
  }
}
