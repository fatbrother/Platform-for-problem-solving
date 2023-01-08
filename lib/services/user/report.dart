import 'package:pops/models/report_model.dart';
import 'package:pops/services/services_base.dart';

// control the database of the problem with problemsModels
class ReportsDataBase extends ServiceBase<ReportsModel>
    with Query, Add {
  @override
  String get tableName => 'reports';

  @override
  ReportsModel fromMap(Map<String, dynamic> map) => ReportsModel.fromMap(map);

  static final ReportsDataBase instance = ReportsDataBase();
}
