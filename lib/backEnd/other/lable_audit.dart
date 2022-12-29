import '../database.dart';

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

class AuditCommandsModel {
  String id;
  String name;
  String commanderId;
  List<String> auditImages;

  AuditCommandsModel({
    this.id = '',
    this.name = '',
    this.commanderId = '',
    this.auditImages = const [],
  });

  AuditCommandsModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        commanderId = map['commanderId'],
        auditImages = map['auditImages'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'commanderId': commanderId,
      'auditImages': auditImages,
    };
  } 
}
