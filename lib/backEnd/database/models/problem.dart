import 'package:cloud_firestore/cloud_firestore.dart';

class ProblemsDatabase {
  static queryAllProblems() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('problems').get();

    // turn all problems into ProblemsModel
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            ProblemsModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static queryProblem(String problemId) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('problems').get();
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
  }

  static deleteProblem(String problemId) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .doc(problemId)
        .delete();
  }

  static addProblem(ProblemsModel problemsModel) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .add(problemsModel.toMap());
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
