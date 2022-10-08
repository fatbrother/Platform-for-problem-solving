import 'package:cloud_firestore/cloud_firestore.dart';

class TagsDatabase {
  static queryAllTags() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('tags').get();

    // turn all tags into TagsModel
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            TagsModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static queryTag(String tagId) async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('tags').get();
    final TagsModel result = TagsModel.fromMap(
        querySnapshot.docs.firstWhere((element) => element.id == tagId).data());
    return result;
  }

  static updateTag(TagsModel tagsModel) async {
    await FirebaseFirestore.instance
        .collection('tags')
        .doc(tagsModel.id.toString())
        .set(tagsModel.toMap());
  }

  static deleteTag(String tagId) async {
    await FirebaseFirestore.instance.collection('tags').doc(tagId).delete();
  }

  static addTag(TagsModel tagsModel) async {
    await FirebaseFirestore.instance.collection('tags').add(tagsModel.toMap());
  }
}

class TagsModel {
  int id;
  String name;
  List<int> problemsWithTag;

  TagsModel(this.id, this.name, this.problemsWithTag);

  static fromMap(Map<String, dynamic> data) {
    return TagsModel(
      // if data have 'id' then use it, else set it to 0
      data['id'] ?? 0,
      data['name'] ?? '',
      data['problemsWithTag'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'problemsWithTag': problemsWithTag};
  }
}
