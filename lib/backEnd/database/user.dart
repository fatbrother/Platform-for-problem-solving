import 'package:cloud_firestore/cloud_firestore.dart';

class UsersDatabase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot =
      FirebaseFirestore.instance.collection('users').get()
          as QuerySnapshot<Map<String, dynamic>>;

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
    await FirebaseFirestore.instance.collection('users').doc(userId).delete();

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
  List<String> askProblemIds;
  List<String> expertiseTagIds;
  int tokens;
  double score;
  int numberOfScores;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone = '',
    this.askProblemIds = const [],
    this.expertiseTagIds = const [],
    this.tokens = 0,
    this.score = 0,
    this.numberOfScores = 0,
  });

  static fromMap(Map<String, dynamic> data) {
    return UsersModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      askProblemIds: data['askProblemIds'] ?? [],
      expertiseTagIds: data['expertiseTagIds'] ?? [],
      tokens: data['tokens'] ?? 0,
      score: data['score'] ?? 0.0,
      numberOfScores: data['numberOfScores'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'askProblemIds': askProblemIds,
      'expertiseTagIds': expertiseTagIds,
      'tokens': tokens,
      'score': score,
      'numberOfScores': numberOfScores,
    };
  }

  bool isVerified() {
    return phone != "";
  }
}
