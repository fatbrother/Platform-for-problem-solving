import 'database.dart';

class TagsDatabase {
  static TrieTree trieTree = TrieTree();

  static void init() async {
    trieTree = TrieTree();
    try {
      await DB.getTable('tags').then((value) {
        for (final tag in value) {
          trieTree.insert(tag['name']);
        }
      });
    } catch (e) {
      rethrow;
    }
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
    try {
      await DB.getRow('tags', tag.id).then((value) {
        trieTree.delete(value['name']);
      });
    } catch (e) {
      rethrow;
    }

    try {
      await DB.updateRow('tags', tag.id, tag.toMap());
    } catch (e) {
      rethrow;
    }

    trieTree.insert(tag.name);
  }

  static void deleteTag(TagsModel tag) async {
    try {
      await DB.deleteRow('tags', tag.id);
    } catch (e) {
      rethrow;
    }

    trieTree.delete(tag.name);
  }

  static void addTag(TagsModel tag) async {
    try {
      await DB.addRow('tags', tag.toMap());
    } catch (e) {
      rethrow;
    }

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
