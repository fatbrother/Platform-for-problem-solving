import 'package:cloud_firestore/cloud_firestore.dart';

class ProblemsDatabase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot =
      FirebaseFirestore.instance.collection('problems').get()
          as QuerySnapshot<Map<String, dynamic>>;

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

  static void updateProblem(ProblemsModel problem) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .doc(problem.id)
        .set(problem.toMap());

    updateQuerySnapshot();
  }

  static void deleteProblem(String problemId) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .doc(problemId)
        .delete();

    updateQuerySnapshot();
  }

  static void addProblem(ProblemsModel problem) async {
    await FirebaseFirestore.instance
        .collection('problems')
        .add(problem.toMap());

    updateQuerySnapshot();
  }

  static void updateQuerySnapshot() async {
    querySnapshot =
        await FirebaseFirestore.instance.collection('problems').get();
  }
}

class ProblemsModel {
  String id;
  String title;
  String description;
  List<String> imgUrls;
  List<int> tags;
  int baseToken;
  bool isSolved;
  List<String> solveCommendIds;
  String chooseSolveCommendId;
  DateTime createdAt;
  int remainingDays;

  ProblemsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrls,
    required this.tags,
    required this.isSolved,
    required this.baseToken,
    required this.solveCommendIds,
    required this.chooseSolveCommendId,
    required this.createdAt,
    required this.remainingDays,
  });

  static fromMap(Map<String, dynamic> data) {
    return ProblemsModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      tags: data['tags'] ?? [],
      description: data['description'] ?? '',
      imgUrls: data['imgUrls'] ?? [],
      isSolved: data['isSolved'] ?? false,
      baseToken: data['baseToken'] ?? 10,
      solveCommendIds: data['solveCommendIds'] ?? [],
      chooseSolveCommendId: data['chooseSolveCommendId'] ?? '',
      createdAt: data['createdAt'] ?? DateTime.now(),
      remainingDays: data['remainingDays'] ?? 3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tags': tags,
      'description': description,
      'imgUrls': imgUrls,
      'isSolved': isSolved,
      'baseToken': baseToken,
      'solveCommendIds': solveCommendIds,
      'createdAt': createdAt,
      'remainingDays': remainingDays,
    };
  }

  get isSolvedString {
    return isSolved ? 'Solved' : 'Unsolved';
  }

  get remainingDaysString {
    return '$remainingDays days';
  }

  get isOverdue {
    return createdAt.add(Duration(days: remainingDays)).isBefore(DateTime.now());
  }

  get remainingTimeString {
    final DateTime now = DateTime.now();
    final DateTime deadline = createdAt.add(Duration(days: remainingDays));
    final Duration remainingTime = deadline.difference(now);
    final int days = remainingTime.inDays;
    final int hours = remainingTime.inHours - days * 24;
    final int minutes = remainingTime.inMinutes - days * 24 * 60 - hours * 60;
    final int seconds =
        remainingTime.inSeconds - days * 24 * 60 * 60 - hours * 60 * 60 - minutes * 60;
    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }
}
