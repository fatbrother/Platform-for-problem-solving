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

  static Future<void> deleteContract(String contractId) async {
    try {
      await DB.deleteRow('contracts', contractId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> addContract(ContractsModel contract) async {
    try {
      final String id = await DB.addRow('contracts', contract.toMap());
      return id;
    } catch (e) {
      rethrow;
    }
  }
}

class ContractsModel {
  String id;
  String solverId;
  String partialAns;
  int price;
  DateTime deadline;

  ContractsModel({
    this.id = '',
    this.solverId = '',
    DateTime? deadline,
    this.partialAns = '',
    this.price = 0,
  }) : deadline = deadline ?? DateTime.now();

  factory ContractsModel.fromMap(Map<String, dynamic> map) {
    return ContractsModel(
      id: map['id'],
      solverId: map['solverId'],
      deadline: DateTime.parse(map['deadline']),
      partialAns: map['partialAns'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'solverId': solverId,
      'deadline': deadline.toIso8601String(),
      'partialAns': partialAns,
      'price': price,
    };
  }

  bool isOverdue() {
    return DateTime.now().isAfter(deadline);
  }
}
