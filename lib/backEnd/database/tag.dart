import 'package:cloud_firestore/cloud_firestore.dart';

class TagsDatabase {
  static QuerySnapshot<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance.collection('tags').get() as QuerySnapshot<Map<String, dynamic>>;

  static Future<void> updateQuerySnapshot() async {
    querySnapshot = await FirebaseFirestore.instance.collection('tags').get();
  }

  static Future<List> queryAllTags() async {
    final List result = querySnapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
            TagsModel.fromMap(doc.data()))
        .toList();
    return result;
  }

  static Future<TagsModel> queryTag(String tagId) async {
    final TagsModel result = TagsModel.fromMap(
        querySnapshot.docs.firstWhere((element) => element.id == tagId).data());
    return result;
  }

  static Future<List> querySimilarTags(String tagName) async {
    final List result = querySnapshot.docs
        .where((element) => (element.data()['name'] as String).contains(tagName))
        .map((e) => TagsModel.fromMap(e.data()))
        .toList();
    return result;
  }

  static void updateTag(TagsModel tagsModel) async {
    await FirebaseFirestore.instance
        .collection('tags')
        .doc(tagsModel.id)
        .set(tagsModel.toMap());

    updateQuerySnapshot();
  }

  static void deleteTag(String tagId) async {
    await FirebaseFirestore.instance.collection('tags').doc(tagId).delete();

    updateQuerySnapshot();
  }

  static void addTag(TagsModel tagsModel) async {
    await FirebaseFirestore.instance.collection('tags').add(tagsModel.toMap());

    updateQuerySnapshot();
  }
}

class TagsModel {
  String id;
  String name;
  List<String> problemsWithTag;

  TagsModel(this.id, this.name, this.problemsWithTag);

  static fromMap(Map<String, dynamic> data) {
    return TagsModel(
      // if data have 'id' then use it, else set it to 0
      data['id'] ?? '',
      data['name'] ?? '',
      data['problemsWithTag'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'problemsWithTag': problemsWithTag};
  }
}
