import 'package:cloud_firestore/cloud_firestore.dart';

class ProblemsDatabase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance.collection('problems').get() as QuerySnapshot<Map<String, dynamic>>;
  
  static queryAllProblems() async {
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            ProblemsModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static queryProblem(String problemId) async {
    final ProblemsModel result = ProblemsModel.fromMap(querySnapshot.docs
        .firstWhere((element) => element.id == problemId)
        .data());
    return result;
  }

  static updateProblem(ProblemsModel problemsModel) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .doc(problemsModel.id.toString())
        .set(problemsModel.toMap());

    updateQuerySnapshot();
  }

  static deleteProblem(String problemId) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .doc(problemId)
        .delete();

    updateQuerySnapshot();
  }

  static addProblem(ProblemsModel problemsModel) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .add(problemsModel.toMap());

    updateQuerySnapshot();
  }

  static updateQuerySnapshot() async {
    querySnapshot = await FirebaseFirestore.instance.collection('problems').get();
  }
}

class ProblemsModel {
  int id;
  String title;
  List<int> tags;

  ProblemsModel(this.id, this.title, this.tags);

  static fromMap(Map<String, dynamic> data) {
    return ProblemsModel(
      // if data have 'id' then use it, else set it to 0
      data['id'] ?? 0,
      data['title'] ?? '',
      data['tags'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'tags': tags};
  }
}
