import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDatabase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance.collection('users').get() as QuerySnapshot<Map<String, dynamic>>;

  static Future<List> queryAllUsers() async {
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            UsersModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static Future<UsersModel> queryUser(String userId) async {
    final UsersModel result = UsersModel.fromMap(querySnapshot.docs
        .firstWhere((element) => element.id == userId)
        .data());
    return result;
  }

  static void updateUser(UsersModel usersModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(usersModel.id.toString())
        .set(usersModel.toMap());

    updateQuerySnapshot();
  }

  static void deleteUser(String userId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .delete();

    updateQuerySnapshot();
  }

  static void addUser(UsersModel usersModel) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add(usersModel.toMap());

    updateQuerySnapshot();
  }

  static void updateQuerySnapshot() async {
    querySnapshot = await FirebaseFirestore.instance.collection('users').get();
  }
}

class UsersModel {
  String id;
  String name;
  String email;
  String phone;

  UsersModel(this.id, this.name, this.email, this.phone);

  static fromMap(Map<String, dynamic> data) {
    return UsersModel(
      data['id'] ?? '',
      data['name'] ?? '',
      data['email'] ?? '',
      data['phone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  bool isVerified() {
    return phone != "";
  }
}