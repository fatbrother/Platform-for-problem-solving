import 'package:pops/models/user_model.dart';
import 'package:pops/services/services_base.dart';

// control the database of the problem with problemsModels
class UsersDatabase extends ServiceBase<UsersModel>
    with
        Query<UsersModel>,
        Update<UsersModel>,
        Delete<UsersModel>,
        Add<UsersModel> {
  @override
  String get tableName => 'users';

  @override
  UsersModel fromMap(Map<String, dynamic> map) {
    return UsersModel.fromMap(map);
  }

  static final UsersDatabase instance = UsersDatabase();
}
