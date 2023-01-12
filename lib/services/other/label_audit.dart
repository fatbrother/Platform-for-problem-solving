import 'package:pops/services/services_base.dart';
import 'package:pops/models/audit_command_model.dart';

// control the database of the contract with contractModel
class AuditCommandsDatabase extends ServiceBase<AuditCommandsModel>
    with Add {
  @override
  String get tableName => 'auditCommands';

  @override
  AuditCommandsModel fromMap(Map<String, dynamic> map) {
    return AuditCommandsModel.fromMap(map);
  }

  static final AuditCommandsDatabase instance = AuditCommandsDatabase();
}
