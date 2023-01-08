import 'package:pops/models/contract_model.dart';
import 'package:pops/services/services_base.dart';

// control the database of the contract with contractModel
class ContractsDatabase extends ServiceBase<ContractsModel>
    with Query, Delete, Add {
  static final ContractsDatabase instance = ContractsDatabase();

  @override
  String get tableName => 'contracts';

  @override
  ContractsModel fromMap(Map<String, dynamic> map) {
    return ContractsModel.fromMap(map);
  }
}
