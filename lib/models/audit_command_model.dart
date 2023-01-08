import 'package:pops/models/model_base.dart';

class AuditCommandsModel extends ModelBase{
  @override
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

  factory AuditCommandsModel.fromMap(Map<String, dynamic> map) {
    return AuditCommandsModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      commanderId: map['commanderId'] ?? '',
      auditImages: map['auditImages'] == null
          ? []
          : map['auditImages'].cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'commanderId': commanderId,
      'auditImages': auditImages,
    };
  } 
}
