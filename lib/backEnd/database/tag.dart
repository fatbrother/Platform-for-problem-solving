import 'package:cloud_firestore/cloud_firestore.dart';

class TagsDatabase {
  static TrieTree trieTree = TrieTree();

  static void init() async {
    trieTree = TrieTree();
    FirebaseFirestore.instance
        .collection('tags')
        .get()
        .then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        trieTree.insert(doc.data()['name']);
      }
    });
  }

  static Future<List> queryAllTags() async {
    final List result = await trieTree.queryAll();
    return result;
  }

  static Future<bool> queryTag(TagsModel tag) async {
    return trieTree.search(tag.name);
  }

  static Future<List> querySimilarTags(TagsModel tag) async {
    final List result = trieTree.startsWith(tag.name);
    return result;
  }

  static void updateTag(TagsModel tag) async {
    String lastTag = await FirebaseFirestore.instance
        .collection('tags')
        .doc(tag.id)
        .get()
        .then((value) => value.data()!['name']);
    trieTree.delete(lastTag);

    await FirebaseFirestore.instance
        .collection('tags')
        .doc(tag.id)
        .set(tag.toMap());
    trieTree.insert(tag.name);
  }

  static void deleteTag(TagsModel tag) async {
    await FirebaseFirestore.instance.collection('tags').doc(tag.id).delete();
    trieTree.delete(tag.name);
  }

  static void addTag(TagsModel tag) async {
    await FirebaseFirestore.instance.collection('tags').add(tag.toMap());
    trieTree.insert(tag.name);
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

class TrieNode {
  Map<String, TrieNode> children = {};
  bool isEnd = false;
  String word = '';
}

class TrieTree {
  TrieNode root = TrieNode();

  void insert(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      if (!node.children.containsKey(word[i])) {
        node.children[word[i]] = TrieNode();
      }
      node = node.children[word[i]]!;
    }
    node.isEnd = true;
  }

  bool search(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      if (!node.children.containsKey(word[i])) {
        return false;
      }
      node = node.children[word[i]]!;
    }
    return node.isEnd;
  }

  List<String> startsWith(String prefix) {
    TrieNode node = root;
    List<String> result = [];
    for (int i = 0; i < prefix.length; i++) {
      if (!node.children.containsKey(prefix[i])) {
        return result;
      }
      node = node.children[prefix[i]]!;
    }
    _getAllWordsBelow(node, result);
    return result;
  }

  Future<List<String>> queryAll() async {
    List<String> result = [];
    _getAllWordsBelow(root, result);
    return result;
  }

  void _getAllWordsBelow(TrieNode root, List<String> result) {
    if (root.isEnd) {
      result.add(root.word);
    }
    for (var key in root.children.keys) {
      root.children[key]!.word = root.word + key;
      _getAllWordsBelow(root.children[key]!, result);
    }
  }

  void delete(String word) {
    TrieNode node = root;
    for (int i = 0; i < word.length; i++) {
      if (!node.children.containsKey(word[i])) {
        return;
      }
      node = node.children[word[i]]!;
    }
    node.isEnd = false;
  }
}
