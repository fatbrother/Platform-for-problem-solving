import 'package:pops/models/model_base.dart';

class ContractsModel extends ModelBase{
  @override
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

  @override
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
