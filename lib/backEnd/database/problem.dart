import 'package:cloud_firestore/cloud_firestore.dart';

class ProblemsDatabase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance.collection('problems').get() as QuerySnapshot<Map<String, dynamic>>;
  
  static Future<List> queryAllProblems() async {
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            ProblemsModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static Future<ProblemsModel> queryProblem(String problemId) async {
    final ProblemsModel result = ProblemsModel.fromMap(querySnapshot.docs
        .firstWhere((element) => element.id == problemId)
        .data());
    return result;
  }

  static Future<List> queryProblemsWithTags(String tagId) async {
    final List result = querySnapshot.docs
        .where((element) => (element.data()['tags'] as List<String>).contains(tagId))
        .map((e) => ProblemsModel.fromMap(e.data()))
        .toList();
    return result;
  }

  static void updateProblem(ProblemsModel problemsModel) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .doc(problemsModel.id)
        .set(problemsModel.toMap());

    updateQuerySnapshot();
  }

  static void deleteProblem(String problemId) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .doc(problemId)
        .delete();

    updateQuerySnapshot();
  }

  static void addProblem(ProblemsModel problemsModel) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .add(problemsModel.toMap());

    updateQuerySnapshot();
  }

  static void updateQuerySnapshot() async {
    querySnapshot = await FirebaseFirestore.instance.collection('problems').get();
  }
}

class ProblemsModel {
  String id;
  String title;
  List<int> tags;

  ProblemsModel(this.id, this.title, this.tags);

  static fromMap(Map<String, dynamic> data) {
    return ProblemsModel(
      // if data have 'id' then use it, else set it to 0
      data['id'] ?? '',
      data['title'] ?? '',
      data['tags'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'tags': tags};
  }
}
