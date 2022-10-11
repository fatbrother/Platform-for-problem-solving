import 'package:cloud_firestore/cloud_firestore.dart';

class SolveCommendsDatabase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot =
      FirebaseFirestore.instance.collection('solveCommends').get()
          as QuerySnapshot<Map<String, dynamic>>;

  static Future<List> queryAllSolveCommends() async {
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            SolveCommendsModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static Future<SolveCommendsModel> querySolveCommend(String solveCommendId) async {
    final SolveCommendsModel result = SolveCommendsModel.fromMap(querySnapshot.docs
        .firstWhere((element) => element.id == solveCommendId)
        .data());
    return result;
  }

  static Future<void> updateSolveCommend(SolveCommendsModel solveCommend) async {
    await FirebaseFirestore.instance
        .collection('solveCommends')
        .doc(solveCommend.id)
        .set(solveCommend.toMap());

    updateQuerySnapshot();
  }

  static Future<void> deleteSolveCommend(String solveCommendId) async {
    await FirebaseFirestore.instance
        .collection('solveCommends')
        .doc(solveCommendId)
        .delete();

    updateQuerySnapshot();
  }

  static Future<void> addSolveCommend(SolveCommendsModel solveCommend) async {
    await FirebaseFirestore.instance
        .collection('solveCommends')
        .add(solveCommend.toMap());

    updateQuerySnapshot();
  }

  static Future<void> updateQuerySnapshot() async {
    querySnapshot =
        await FirebaseFirestore.instance.collection('solveCommends').get();
  }
}

class SolveCommendsModel {
  String id;
  String commendUserId;
  int tokens;

  SolveCommendsModel({
    required this.id,
    required this.commendUserId,
    required this.tokens,
  });

  static fromMap(Map<String, dynamic> map) {
    return SolveCommendsModel(
      id: map['id'],
      commendUserId: map['commendUserId'],
      tokens: map['tokens'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'commendUserId': commendUserId,
      'tokens': tokens,
    };
  }  
}