import 'package:firebase_core/firebase_core.dart';

class TagsModel {
  int id;
  String name;
  List<int> problemsWithTag;

  TagsModel(this.id, this.name, this.problemsWithTag);
}

class ProblemsModel {
  int id;
  String title;
  List<int> tags;

  ProblemsModel(this.id, this.title, this.tags);
}

class UsersModel {
  int id;
  String name;
  String email;
  String role;
  List<int> problemsSolved;

  UsersModel(this.id, this.name, this.email, this.role,
      this.problemsSolved);
}