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
