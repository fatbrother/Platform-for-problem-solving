import '../database.dart';

// control the database of the contract with contractModel
class ContractsDatabase {
  static Future<List> queryAllContracts() async {
    try {
      final List result = await DB.getTable('contracts');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ContractsModel> queryContract(String contractId) async {
    try {
      final Map<String, dynamic> result =
          await DB.getRow('contracts', contractId);
      return ContractsModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  static void updateContract(ContractsModel contract) async {
    try {
      await DB.updateRow('contracts', contract.id, contract.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static void deleteContract(String contractId) async {
    try {
      await DB.deleteRow('contracts', contractId);
    } catch (e) {
      rethrow;
    }
  }

  static void addContract(ContractsModel contract) async {
    try {
      await DB.addRow('contracts', contract.toMap());
    } catch (e) {
      rethrow;
    }
  }
}

class ContractsModel {
  String id;
  String requestId;
  String solverId;
  String problemId;
  DateTime deadline;

  ContractsModel({
    required this.id,
    required this.requestId,
    required this.solverId,
    required this.problemId,
    required this.deadline,
  });

  factory ContractsModel.fromMap(Map<String, dynamic> map) {
    return ContractsModel(
      id: map['id'],
      requestId: map['requestId'],
      solverId: map['solverId'],
      problemId: map['problemId'],
      deadline: DateTime.parse(map['deadline']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'requestId': requestId,
      'solverId': solverId,
      'problemId': problemId,
      'deadline': deadline.toIso8601String(),
    };
  }

  bool isOverdue() {
    return DateTime.now().isAfter(deadline);
  }
}
